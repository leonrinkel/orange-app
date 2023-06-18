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
            StoriesView(stories: newsProvider.topStories)
                .navigationTitle("Top Stories")
        }
        .task {
            try? await newsProvider.fetchTopStories()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NewsProvider())
    }
}
