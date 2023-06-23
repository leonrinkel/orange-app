//
//  SavedStoryRowView.swift
//  Orange
//
//  Created by Leon Rinkel on 23.06.23.
//

import SwiftUI

struct SavedStoryRowView: View {
    var savedStory: SavedStory

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        HStack {
            // TODO: display even if there is no link (asks)
            if let parsedUrl = savedStory.parsedURL,
               let time = savedStory.time,
               let title = savedStory.title,
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
    }
}

//struct SavedStoryRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedStoryRowView()
//    }
//}
