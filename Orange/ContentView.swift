//
//  ContentView.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var newsProvider: NewsProvider

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        StoriesView(stories: newsProvider.topStories)
                            .navigationTitle("Top Stories 🔝")
                            .task {
                                try? await newsProvider.fetchTopStories()
                            }
                    } label: {
                        HStack {
                            Text("🔝")
                                .frame(width: 24)
                            Text("Top Stories")
                        }
                    }
                    NavigationLink {
                        StoriesView(stories: newsProvider.newStories)
                            .navigationTitle("New Stories 🆕")
                            .task {
                                try? await newsProvider.fetchNewStories()
                            }
                    } label: {
                        HStack {
                            Text("🆕")
                                .frame(width: 24)
                            Text("New Stories")
                        }
                    }
                    NavigationLink {
                        StoriesView(stories: newsProvider.bestStories)
                            .navigationTitle("Best Stories 🔥")
                            .task {
                                try? await newsProvider.fetchBestStories()
                            }
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
            }
            .navigationTitle("Orange")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NewsProvider(implementation: MockNewsProviderImplementation()))
    }
}
