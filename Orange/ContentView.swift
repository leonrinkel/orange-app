//
//  ContentView.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var networkFactory: NetworkFactory

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
            }
            .navigationTitle("Orange")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NetworkFactory(implementation: MockNetworkFactoryImplementation()))
    }
}
