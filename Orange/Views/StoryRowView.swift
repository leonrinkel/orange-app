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
        HStack {
            // TODO: display even if there is no link (asks)
            if let story = storyProvider.story,
               let parsedUrl = story.parsedURL,
               let time = story.time,
               let title = story.title,
               let host = parsedUrl.host() {
                NavigationLink {
                    SafariView(url: parsedUrl)
                        .ignoresSafeArea()
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(dateFormatter.string(from: time))
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text(host)
                                .font(.caption)
                                .foregroundColor(.accentColor)
                                .lineLimit(1)
                            Text(parsedUrl.path())
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text("...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("...")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        Text("...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
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
