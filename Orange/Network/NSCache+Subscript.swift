//
//  NSCache+Subscript.swift
//  Orange
//
//  Created by Leon Rinkel on 27.06.23.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
    subscript(_ id: Int) -> CacheEntry? {
        get {
            let key = "Item_\(id)" as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = "Item_\(id)" as NSString
            if let entry = newValue {
                let value = CacheEntryObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
