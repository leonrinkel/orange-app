//
//  NetworkFactory.swift
//  Orange
//
//  Created by Leon Rinkel on 19.06.23.
//

import Foundation

protocol NetworkFactoryImplementation {
    func newStoriesProvider(for list: NewsApi.List) -> StoriesProvider
    func newStoryProvider(for id: Int) -> StoryProvider
}

class DefaultNetworkFactoryImplementation: NetworkFactoryImplementation {
    @MainActor func newStoriesProvider(for list: NewsApi.List) -> StoriesProvider {
        return StoriesProvider(for: list, implementation: DefaultStoriesProviderImplementation())
    }
    
    @MainActor func newStoryProvider(for id: Int) -> StoryProvider {
        return StoryProvider(for: id, implementation: DefaultStoryProviderImplementation())
    }
}

class MockNetworkFactoryImplementation: NetworkFactoryImplementation {
    @MainActor func newStoriesProvider(for list: NewsApi.List) -> StoriesProvider {
        return StoriesProvider(for: list, implementation: MockStoriesProviderImplementation())
    }
    
    @MainActor func newStoryProvider(for id: Int) -> StoryProvider {
        return StoryProvider(for: id, implementation: MockStoryProviderImplementation())
    }
}

class NetworkFactory: ObservableObject {
    private let implementation: any NetworkFactoryImplementation
    
    init(implementation: any NetworkFactoryImplementation) {
        self.implementation = implementation
    }
    
    func newStoriesProvider(for list: NewsApi.List) -> StoriesProvider {
        return implementation.newStoriesProvider(for: list)
    }
    
    func newStoryProvider(for id: Int) -> StoryProvider {
        return implementation.newStoryProvider(for: id)
    }
}
