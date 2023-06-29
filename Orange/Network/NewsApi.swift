//
//  NewsApi.swift
//  Orange
//
//  Created by Leon Rinkel on 29.06.23.
//

import Foundation

class NewsApi {
    static let decoder: JSONDecoder = {
        let myDecoder = JSONDecoder()
        myDecoder.dateDecodingStrategy = .secondsSince1970
        return myDecoder
    }()
    
    static func url(for path: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "hacker-news.firebaseio.com"
        components.path = path
        return components.url!
    }
    
    enum List: String {
        case topStories = "/v0/topstories.json"
        case newStories = "/v0/newstories.json"
        case bestStories = "/v0/beststories.json"
        case askStories = "/v0/askstories.json"
        case showStories = "/v0/showstories.json"
        case jobStories = "/v0/jobstories.json"
    }
    
    static let itemCache: NSCache<NSString, CacheEntryObject> = NSCache()
}
