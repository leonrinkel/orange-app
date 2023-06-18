//
//  StoriesView.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import SwiftUI

struct StoriesView: View {
    var stories: [Item]

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        List(stories) { story in
            Link(destination: story.parsedURL!) {
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
        }
    }
}

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView(stories: Item.sampleStories)
    }
}
