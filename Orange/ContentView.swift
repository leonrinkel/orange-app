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
    
    @State private var topStoriesProvider: StoriesProvider?
    @State private var newStoriesProvider: StoriesProvider?
    @State private var bestStoriesProvider: StoriesProvider?
    @State private var askStoriesProvider: StoriesProvider?
    @State private var showStoriesProvider: StoriesProvider?
    @State private var jobStoriesProvider: StoriesProvider?
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        StoriesView(storiesProvider: topStoriesProvider!)
                            .navigationTitle("Top Stories 🔝")
                    } label: {
                        Label {
                            Text("Top Stories")
                        } icon: {
                            Text("🔝")
                        }
                    }
                    NavigationLink {
                        StoriesView(storiesProvider: newStoriesProvider!)
                            .navigationTitle("New Stories 🆕")
                    } label: {
                        Label {
                            Text("New Stories")
                        } icon: {
                            Text("🆕")
                        }
                    }
                    NavigationLink {
                        StoriesView(storiesProvider: bestStoriesProvider!)
                            .navigationTitle("Best Stories 🥇")
                    } label: {
                        Label {
                            Text("Best Stories")
                        } icon: {
                            Text("🥇")
                        }
                    }
                } header: {
                    Text("Lists")
                }
                Section {
                    NavigationLink {
                        StoriesView(storiesProvider: askStoriesProvider!)
                            .navigationTitle("Ask Stories ❓")
                    } label: {
                        Label {
                            Text("Ask Stories")
                        } icon: {
                            Text("❓")
                        }
                    }
                    NavigationLink {
                        StoriesView(storiesProvider: showStoriesProvider!)
                            .navigationTitle("Show Stories 👀")
                    } label: {
                        Label {
                            Text("Show Stories")
                        } icon: {
                            Text("👀")
                        }
                    }
                    NavigationLink {
                        StoriesView(storiesProvider: jobStoriesProvider!)
                            .navigationTitle("Job Stories 🧑‍💼")
                    } label: {
                        Label {
                            Text("Job Stories")
                        } icon: {
                            Text("🧑‍💼")
                        }
                    }
                } header: {
                    Text("Types")
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
            .navigationTitle("Orange 🍊")
            .onAppear {
                Task {
                    if topStoriesProvider == nil {
                        topStoriesProvider = networkFactory.newStoriesProvider(for: .topStories)
                    }
                    if newStoriesProvider == nil {
                        newStoriesProvider = networkFactory.newStoriesProvider(for: .newStories)
                    }
                    if bestStoriesProvider == nil {
                        bestStoriesProvider = networkFactory.newStoriesProvider(for: .bestStories)
                    }
                }
                Task {
                    if askStoriesProvider == nil {
                        askStoriesProvider = networkFactory.newStoriesProvider(for: .askStories)
                    }
                    if showStoriesProvider == nil {
                        showStoriesProvider = networkFactory.newStoriesProvider(for: .showStories)
                    }
                    if jobStoriesProvider == nil {
                        jobStoriesProvider = networkFactory.newStoriesProvider(for: .jobStories)
                    }
                }
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
