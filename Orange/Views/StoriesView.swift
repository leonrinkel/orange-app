//
//  StoriesView.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import SwiftUI

struct StoriesView: View {
    var stories: [Item]

    var body: some View {
        List(stories) { story in
            VStack(alignment: .leading) {
                if let title = story.title {
                    Text(title)
                        .font(.headline)
                }
                if let parsedUrl = story.parsedURL {
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        if let host = parsedUrl.host() {
                            Text(host)
                                .font(.caption)
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

struct StoriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoriesView(stories: Item.sampleStories)
    }
}
