//
//  NewsProvider.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import Foundation

@MainActor
class NewsProvider: ObservableObject {
    private let newsClient = NewsClient()

    @Published var topStories: [Item] = []
    @Published var newStories: [Item] = []
    @Published var bestStories: [Item] = []
    
    @Published var askStories: [Item] = []
    @Published var showStories: [Item] = []
    @Published var jobStories: [Item] = []
    
    func fetchTopStories() async throws {
        let ids = try await newsClient.stories(from: .topStories)
        try await withThrowingTaskGroup(of: Item.self) { group in
            for id in ids {
                group.addTask { [self] in
                    return try await newsClient.item(with: id)
                }
            }
            topStories = []
            for try await result in group {
                topStories.append(result)
            }
        }
    }
}
