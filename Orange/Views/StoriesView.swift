//
//  StoriesView.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import SwiftUI

struct StoriesView: View {
    @EnvironmentObject var networkFactory: NetworkFactory
    @StateObject var storiesProvider: StoriesProvider

    var body: some View {
        List(storiesProvider.stories, id: \.self) { storyId in
            StoryRowView(storyProvider: networkFactory.newStoryProvider(for: storyId))
        }
        .task {
            try? await storiesProvider.fetchStories()
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        let networkFactory = NetworkFactory(implementation: MockNetworkFactoryImplementation())
        return StoriesView(storiesProvider: networkFactory.newStoriesProvider(for: .topStories))
            .environmentObject(networkFactory)
    }
}
