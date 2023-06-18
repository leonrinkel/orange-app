//
//  OrangeApp.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import SwiftUI

@main
struct OrangeApp: App {
    @StateObject var newsProvider = NewsProvider()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(newsProvider)
        }
    }
}
