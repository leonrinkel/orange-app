//
//  StoryRowView.swift
//  Orange
//
//  Created by Leon Rinkel on 19.06.23.
//

import SwiftUI

struct StoryRowView: View {
    @StateObject var storyProvider: StoryProvider

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            if let story = storyProvider.story, let parsedUrl = story.parsedURL {
                Link(destination: parsedUrl) {
                    VStack(alignment: .leading, spacing: 4) {
                        if let time = story.time {
                            Text(dateFormatter.string(from: time))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        if let title = story.title {
                            Text(title)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        if let parsedUrl = story.parsedURL {
                            HStack(alignment: .firstTextBaseline, spacing: 0) {
                                if let host = parsedUrl.host() {
                                    Text(host)
                                        .font(.caption)
                                        .foregroundColor(.accentColor)
                                        .lineLimit(1)
                                }
                                Text(parsedUrl.path())
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                        }
                    }
                }
            } else {
                Text("Loading...")
                    .foregroundColor(.secondary)
            }
        }
        .onAppear {
            Task {
                try? await storyProvider.fetchStory()
            }
        }
    }
}

struct StoryRow_Previews: PreviewProvider {
    static var previews: some View {
        StoryRowView(storyProvider: StoryProvider(implementation: MockStoryProviderImplementation(id: Item.sampleStories[0].id)))
    }
}
