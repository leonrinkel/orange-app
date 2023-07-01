//
//  StoriesProvider.swift
//  Orange
//
//  Created by Leon Rinkel on 19.06.23.
//

import Foundation
import Alamofire

// TODO: consistent naming story/item/list

protocol StoriesProviderImplementation {
    func fetch(list: NewsApi.List) async throws -> [ItemId]
}

class DefaultStoriesProviderImplementation: StoriesProviderImplementation {
    func fetch(list: NewsApi.List) async throws -> [ItemId] {
        return try await AF
            .request(NewsApi.url(for: list.rawValue))
            .validate()
            .serializingDecodable([ItemId].self).value
    }
}

class MockStoriesProviderImplementation: StoriesProviderImplementation {
    func fetch(list: NewsApi.List) async throws -> [ItemId] {
        return Item.sampleStories.map { $0.id }
    }
}

@MainActor
class StoriesProvider: ObservableObject {
    private let list: NewsApi.List
    private let implementation: any StoriesProviderImplementation
    
    @Published var stories: [ItemId] = []

    init(for list: NewsApi.List, implementation: any StoriesProviderImplementation = DefaultStoriesProviderImplementation()) {
        self.list = list
        self.implementation = implementation
    }
    
    func fetchStories() async throws {
        try await stories = implementation.fetch(list: list)
    }
}
