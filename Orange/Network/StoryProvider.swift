//
//  StoryProvider.swift
//  Orange
//
//  Created by Leon Rinkel on 19.06.23.
//

// TODO: consistent naming story/item

import Foundation
import Alamofire

protocol StoryProviderImplementation {
    func fetch(with id: Int) async throws -> Item
}

class DefaultStoryProviderImplementation: StoryProviderImplementation {
    func fetch(with id: Int) async throws -> Item {
        return try await AF
            .request(NewsApi.url(for: "/v0/item/\(id).json"))
            .validate()
            .serializingDecodable(Item.self, decoder: NewsApi.decoder).value
    }
}

class MockStoryProviderImplementation: StoryProviderImplementation {
    func fetch(with id: Int) async throws -> Item {
        return Item.sampleStories.first(where: { $0.id == id })!
    }
}

@MainActor
class StoryProvider: ObservableObject {
    private let id: Int
    private let implementation: any StoryProviderImplementation
    
    @Published var story: Item?
    
    init(for id: Int, implementation: any StoryProviderImplementation = DefaultStoryProviderImplementation()) {
        self.id = id
        self.implementation = implementation
    }
    
    func fetchStory() async throws {
        if let cached = NewsApi.itemCache[id] {
            switch cached {
            case .ready(let item):
                return self.story = item
            case .inProgress(let task):
                let item = try await task.value
                return self.story = item
            }
        }
        
        let task = Task<Item, Error> { try await implementation.fetch(with: id) }
        
        NewsApi.itemCache[id] = .inProgress(task)
        do {
            let item = try await task.value
            self.story = item
            NewsApi.itemCache[id] = .ready(item)
        } catch {
            NewsApi.itemCache[id] = nil
            throw error
        }
    }
}
