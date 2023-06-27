//
//  NewsProvider.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import Foundation

protocol NewsProviderImplementation {
    func fetchTopStories() async throws -> [Item]
    func fetchNewStories() async throws -> [Item]
    func fetchBestStories() async throws -> [Item]
}

class DefaultNewsProviderImplementation: NewsProviderImplementation {
    private let newsClient: NewsClient = .shared

    private func fetch(from endpoint: NewsClient.Endpoint) async throws -> [Item] {
        let ids = try await newsClient.stories(from: endpoint)
        return try await withThrowingTaskGroup(of: Item.self) { group in
            for id in ids.prefix(25) {
                group.addTask { [self] in
                    return try await newsClient.item(with: id)
                }
            }
            var topStories: [Item] = []
            for try await result in group {
                topStories.append(result)
            }
            return topStories
        }
    }
    
    func fetchTopStories() async throws -> [Item] {
        return try await fetch(from: .topStories)
    }
    
    func fetchNewStories() async throws -> [Item] {
        return try await fetch(from: .newStories)
    }
    
    func fetchBestStories() async throws -> [Item] {
        return try await fetch(from: .bestStories)
    }
}

class MockNewsProviderImplementation: NewsProviderImplementation {    
    func fetchTopStories() async throws -> [Item] {
        return Item.sampleStories
    }
    
    func fetchNewStories() async throws -> [Item] {
        return Item.sampleStories
    }
    
    func fetchBestStories() async throws -> [Item] {
        return Item.sampleStories
    }
}

@MainActor
class NewsProvider: ObservableObject {
    private let implementation: any NewsProviderImplementation
    
    @Published var topStories: [Item] = []
    @Published var newStories: [Item] = []
    @Published var bestStories: [Item] = []
    
    @Published var askStories: [Item] = []
    @Published var showStories: [Item] = []
    @Published var jobStories: [Item] = []
    
    init(implementation: any NewsProviderImplementation = DefaultNewsProviderImplementation()) {
        self.implementation = implementation
    }
    
    func fetchTopStories() async throws {
        topStories = try await implementation.fetchTopStories()
    }
    
    func fetchNewStories() async throws {
        newStories = try await implementation.fetchNewStories()
    }
    
    func fetchBestStories() async throws {
        bestStories = try await implementation.fetchBestStories()
    }
}
