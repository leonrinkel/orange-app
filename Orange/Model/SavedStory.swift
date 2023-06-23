//
//  SavedStory.swift
//  Orange
//
//  Created by Leon Rinkel on 23.06.23.
//

import Foundation
import CoreData

extension SavedStory {
    convenience init(context: NSManagedObjectContext, from story: Item) {
        self.init(context: context)
        self.id = Int64(story.id)
        self.time = story.time
        self.url = story.url
        self.title = story.title
    }
    
    var parsedURL: URL? {
        if let url = self.url {
            if !url.isEmpty {
                return URL(string: url)
            }
        }
        return nil
    }
}
