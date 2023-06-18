//
//  Item.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import Foundation

struct Item: Identifiable, Decodable {
    var id: Int
    var deleted: Bool?
    var type: ItemType?
    var by: String?
    var time: Date?
    var text: String?
    var dead: Bool?
    var parent: Int?
    var poll: Int?
    var kids: [Int]?
    var url: String?
    var score: Int?
    var title: String?
    var parts: [Int]?
    var descendants: Int?
    
    enum ItemType: String, Codable {
        case job
        case story
        case comment
        case poll
        case pollopt
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
