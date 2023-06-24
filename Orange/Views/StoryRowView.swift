//
//  StoryRowView.swift
//  Orange
//
//  Created by Leon Rinkel on 19.06.23.
//

import SwiftUI
import CoreData

struct StoryRowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var storyProvider: StoryProvider
    @State var savedStory: SavedStory?

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
        .swipeActions {
            if let savedStory {
                Button {
                    viewContext.delete(savedStory)
                    self.savedStory = nil
                    do {
                        try viewContext.save()
                    } catch {
                        // TODO: Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                } label: {
                    Label("Unsave", systemImage: "bookmark.slash.fill")
                }
                .tint(.red)
            } else {
                Button {
                    if let story = storyProvider.story {
                        savedStory = SavedStory(context: viewContext, from: story)
                        do {
                            try viewContext.save()
                        } catch {
                            // TODO: Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                } label: {
                    Label("Save", systemImage: "bookmark.fill")
                }
                .tint(.accentColor)
            }
        }
        .onAppear {
            Task {
                try? await storyProvider.fetchStory()
            }
        }
        .onChange(of: storyProvider.story) { story in
            if let story = story {
                let request = SavedStory.fetchRequest()
                request.predicate = NSPredicate(format: "id = \(story.id)")
                request.fetchLimit = 1
                if let savedStories = try? viewContext.fetch(request) {
                    savedStory = savedStories.first
                }
            }
        }
        .contextMenu {
            if let story = storyProvider.story, let parsedUrl = story.parsedURL {
                Link(destination: parsedUrl) {
                    Label("Open in Safari", systemImage: "safari")
                }
            }
            if let savedStory {
                Button {
                    viewContext.delete(savedStory)
                    self.savedStory = nil
                    do {
                        try viewContext.save()
                    } catch {
                        // TODO: Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                } label: {
                    Label("Unsave", systemImage: "bookmark.slash")
                }
            }
            else {
                Button {
                    if let story = storyProvider.story {
                        savedStory = SavedStory(context: viewContext, from: story)
                        do {
                            try viewContext.save()
                        } catch {
                            // TODO: Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                } label: {
                    Label("Save", systemImage: "bookmark")
                }
            }
        }
    }
}

struct StoryRow_Previews: PreviewProvider {
    static var previews: some View {
        StoryRowView(storyProvider: StoryProvider(implementation: MockStoryProviderImplementation(id: Item.sampleStories[0].id)))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
