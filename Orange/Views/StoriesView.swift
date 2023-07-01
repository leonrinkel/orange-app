//
//  StoriesView.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import SwiftUI
import SkeletonUI

struct StoriesView: View {
    @EnvironmentObject var networkFactory: NetworkFactory
    @StateObject var storiesProvider: StoriesProvider

    var body: some View {
        VStack() {
            SkeletonList(with: storiesProvider.stories, quantity: 5) { loading, story in
                VStack {
                    if let storyId = story?.id {
                        StoryRowView(storyProvider: networkFactory.newStoryProvider(for: storyId))
                    } else {
                        SkeletonStoryRowView()
                    }
                }
            }
            .refreshable {
                try? await storiesProvider.fetchStories()
            }
        }
        .task {
            if storiesProvider.stories.isEmpty {
                try? await storiesProvider.fetchStories()
            }
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        let networkFactory = NetworkFactory(implementation: MockNetworkFactoryImplementation())
        return StoriesView(storiesProvider: networkFactory.newStoriesProvider(for: .topStories))
            .environmentObject(networkFactory)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
