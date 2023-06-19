//
//  NetworkFactory.swift
//  Orange
//
//  Created by Leon Rinkel on 19.06.23.
//

import Foundation

protocol NetworkFactoryImplementation {
    func newStoriesProvider(for endpoint: NewsClient.Endpoint) -> StoriesProvider
    func newStoryProvider(for id: Int) -> StoryProvider
}

class DefaultNetworkFactoryImplementation: NetworkFactoryImplementation {
    @MainActor func newStoriesProvider(for endpoint: NewsClient.Endpoint) -> StoriesProvider {
        return StoriesProvider(implementation: DefaultStoriesProviderImplementation(endpoint: endpoint))
    }
    
    @MainActor func newStoryProvider(for id: Int) -> StoryProvider {
        return StoryProvider(implementation: DefaultStoryProviderImplementation(id: id))
    }
}

class MockNetworkFactoryImplementation: NetworkFactoryImplementation {
    @MainActor func newStoriesProvider(for endpoint: NewsClient.Endpoint) -> StoriesProvider {
        return StoriesProvider(implementation: MockStoriesProviderImplementation(endpoint: endpoint))
    }
    
    @MainActor func newStoryProvider(for id: Int) -> StoryProvider {
        return StoryProvider(implementation: MockStoryProviderImplementation(id: id))
    }
}

class NetworkFactory: ObservableObject {
    private let implementation: any NetworkFactoryImplementation
    
    init(implementation: any NetworkFactoryImplementation) {
        self.implementation = implementation
    }
    
    func newStoriesProvider(for endpoint: NewsClient.Endpoint) -> StoriesProvider {
        return implementation.newStoriesProvider(for: endpoint)
    }
    
    func newStoryProvider(for id: Int) -> StoryProvider {
        return implementation.newStoryProvider(for: id)
    }
}
