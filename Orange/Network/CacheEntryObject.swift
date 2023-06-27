//
//  CacheEntryObject.swift
//  Orange
//
//  Created by Leon Rinkel on 27.06.23.
//

import Foundation

class CacheEntryObject {
    let entry: CacheEntry
    
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

enum CacheEntry {
    case inProgress(Task<Item, Error>)
    case ready(Item)
}
