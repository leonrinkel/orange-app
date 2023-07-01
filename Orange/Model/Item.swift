//
//  Item.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import Foundation

typealias ItemId = Int

extension ItemId: Identifiable {
    public var id: Int { self }
}

struct Item: Identifiable, Decodable, Equatable {
    var id: ItemId
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

extension Item {
    static let sampleStories = [
        Item(id: 36378689, type: .story, by: "majkinetor", time: Date(timeIntervalSince1970: 1687081404), kids: [ 36381034, 36381235, 36379872, 36381294, 36381174, 36381260, 36379258, 36379613, 36380459, 36379625, 36381090, 36380827, 36379213, 36379262, 36380507, 36379908, 36380571, 36381212, 36379282, 36380166, 36379954, 36380389, 36378948, 36381166, 36380735, 36379717, 36380263, 36380103, 36379922, 36379403, 36379257, 36379269, 36379691, 36379073 ], url: "https://github.com/jellyfin/jellyfin", score: 321, title: "Jellyfin: The Free Software Media System", descendants: 187),
        Item(id: 36380711, type: .story, by: "majkinetor", time: Date(timeIntervalSince1970: 1687099367), kids: [ 36381239, 36381275, 36381434, 36381284, 36380909, 36381416, 36381262 ], url: "https://cerebralab.com/Imaginary_Problems_Are_the_Root_of_Bad_Software", score: 50, title: "Imaginary Problems Are the Root of Bad Software", descendants: 11)
    ]
}
