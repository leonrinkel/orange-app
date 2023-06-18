//
//  User.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import Foundation

struct User: Identifiable, Decodable {
    var id: String
    var created: Date
    var karma: Int
    var about: String?
    var submitted: [Int]?
}
