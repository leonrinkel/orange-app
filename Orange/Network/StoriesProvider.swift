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
    func fetch(list: NewsApi.List) async throws -> [Int]
}

class DefaultStoriesProviderImplementation: StoriesProviderImplementation {
    func fetch(list: NewsApi.List) async throws -> [Int] {
        return try await AF
            .request(NewsApi.url(for: list.rawValue))
            .validate()
            .serializingDecodable([Int].self).value
    }
}

class MockStoriesProviderImplementation: StoriesProviderImplementation {
    func fetch(list: NewsApi.List) async throws -> [Int] {
        return Item.sampleStories.map { $0.id }
    }
}

@MainActor
class StoriesProvider: ObservableObject {
    private let list: NewsApi.List
    private let implementation: any StoriesProviderImplementation
    
    @Published var stories: [Int] = []

    init(for list: NewsApi.List, implementation: any StoriesProviderImplementation = DefaultStoriesProviderImplementation()) {
        self.list = list
        self.implementation = implementation
    }
    
    func fetchStories() async throws {
        try await stories = implementation.fetch(list: list)
    }
}
