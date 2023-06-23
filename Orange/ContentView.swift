//
//  ContentView.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var networkFactory: NetworkFactory
    @Environment(\.managedObjectContext) private var viewContext

    @State var savedStoriesCount: Int?
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        StoriesView(storiesProvider: networkFactory.newStoriesProvider(for: .topStories))
                            .navigationTitle("Top Stories 🔝")
                    } label: {
                        HStack {
                            Text("🔝")
                                .frame(width: 24)
                            Text("Top Stories")
                        }
                    }
                    NavigationLink {
                        StoriesView(storiesProvider: networkFactory.newStoriesProvider(for: .newStories))
                            .navigationTitle("New Stories 🆕")
                    } label: {
                        HStack {
                            Text("🆕")
                                .frame(width: 24)
                            Text("New Stories")
                        }
                    }
                    NavigationLink {
                        StoriesView(storiesProvider: networkFactory.newStoriesProvider(for: .bestStories))
                            .navigationTitle("Best Stories 🔥")
                    } label: {
                        HStack {
                            Text("🔥")
                                .frame(width: 24)
                            Text("Best Stories")
                        }
                    }
                } header: {
                    Text("Stories")
                }
                Section {
                    NavigationLink {
                        SavedStoriesView()
                            .navigationTitle("Saved Stories 💾")
                    } label: {
                        HStack {
                            Text("💾")
                                .frame(width: 24)
                            Text("Saved Stories")
                                .badge(savedStoriesCount ?? 0)
                        }
                    }
                } header: {
                    Text("Library")
                }
            }
            .navigationTitle("Orange")
            .onAppear {
                Task {
                    let request = SavedStory.fetchRequest()
                    savedStoriesCount = try? viewContext.count(for: request)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NetworkFactory(implementation: MockNetworkFactoryImplementation()))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
