//
//  StoryProvider.swift
//  Orange
//
//  Created by Leon Rinkel on 19.06.23.
//

import Foundation

protocol StoryProviderImplementation {
    init(id: Int)
    func fetchStory() async throws -> Item
}

class DefaultStoryProviderImplementation: StoryProviderImplementation {
    private let newsClient = NewsClient()
    private var id: Int
    
    required init(id: Int) {
        self.id = id
    }
    
    func fetchStory() async throws -> Item {
        return try await newsClient.item(with: id)
    }
}

class MockStoryProviderImplementation: StoryProviderImplementation {
    private var id: Int

    required init(id: Int) {
        self.id = id
    }
    
    func fetchStory() async throws -> Item {
        return Item.sampleStories.first(where: { $0.id == id })!
    }
}

@MainActor
class StoryProvider: ObservableObject {
    private let implementation: any StoryProviderImplementation
    
    @Published var story: Item?
    
    init(implementation: any StoryProviderImplementation)
    {
        self.implementation = implementation
    }
    
    func fetchStory() async throws {
        story = try await implementation.fetchStory()
    }
}
