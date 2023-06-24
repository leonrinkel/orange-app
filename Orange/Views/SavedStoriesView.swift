//
//  SavedStoriesView.swift
//  Orange
//
//  Created by Leon Rinkel on 23.06.23.
//

import SwiftUI
import CoreData

struct SavedStoriesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \SavedStory.time, ascending: true)],
        animation: .default)
    private var savedStories: FetchedResults<SavedStory>
    
    @State var searchQuery: String = ""
    
    var body: some View {
        List {
            ForEach(savedStories) { savedStory in
                SavedStoryRowView(savedStory: savedStory)
            }
            .onDelete { indexSet in
                indexSet.map { savedStories[$0] }.forEach(viewContext.delete)
                
                do {
                    try viewContext.save()
                } catch {
                    // TODO: Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        .searchable(text: $searchQuery)
        .onChange(of: searchQuery) { newQuery in
            savedStories.nsPredicate = newQuery.isEmpty ? nil : NSPredicate(format: "title CONTAINS[c] %@", newQuery)
        }
    }
}

struct SavedStoriesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedStoriesView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
