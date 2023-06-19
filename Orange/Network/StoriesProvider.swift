//
//  StoriesProvider.swift
//  Orange
//
//  Created by Leon Rinkel on 19.06.23.
//

import Foundation

protocol StoriesProviderImplementation {
    init(endpoint: NewsClient.Endpoint)
    func fetchStories() async throws -> [Int]
}

class DefaultStoriesProviderImplementation: StoriesProviderImplementation {
    private let newsClient = NewsClient()
    private var endpoint: NewsClient.Endpoint
    
    required init(endpoint: NewsClient.Endpoint) {
        self.endpoint = endpoint
    }
    
    func fetchStories() async throws -> [Int] {
        return try await newsClient.stories(from: endpoint)
    }
}

class MockStoriesProviderImplementation: StoriesProviderImplementation {
    required init(endpoint: NewsClient.Endpoint) {}

    func fetchStories() async throws -> [Int] {
        return Item.sampleStories.map { $0.id }
    }
}

@MainActor
class StoriesProvider: ObservableObject {
    private let implementation: any StoriesProviderImplementation
    
    @Published var stories: [Int] = []

    init(implementation: any StoriesProviderImplementation) {
        self.implementation = implementation
    }
    
    func fetchStories() async throws {
        stories = try await implementation.fetchStories()
    }
}
