//
//  OrangeApp.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import SwiftUI

@main
struct OrangeApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var networkFactory = NetworkFactory(implementation: DefaultNetworkFactoryImplementation())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(networkFactory)
        }
    }
}
