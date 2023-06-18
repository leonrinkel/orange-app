//
//  NewsClient.swift
//  Orange
//
//  Created by Leon Rinkel on 18.06.23.
//

import Foundation

actor NewsClient {
    static let validStatus = 200...299
    
    enum Endpoint: String {
        case maxItem = "/v0/maxitem.json"
        case topStories = "/v0/topstories.json"
        case newStories = "/v0/newstories.json"
        case bestStories = "/v0/beststories.json"
        case askStories = "/v0/askstories.json"
        case showStories = "/v0/showstories.json"
        case jobStories = "/v0/jobstories.json"
        case updates = "/v0/updates.json"
    }
    
    private let urlSession: URLSession = .shared
    private let decoder: JSONDecoder = {
        let myDecoder = JSONDecoder()
        myDecoder.dateDecodingStrategy = .secondsSince1970
        return myDecoder
    }()
    
    nonisolated func url(for path: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "hacker-news.firebaseio.com"
        components.path = path
        return components.url!
    }
    
    enum ClientError: Error {
        case networkError
        case decodeError
        case unknownError
    }
    
    func request(from url: URL) async throws -> Data {
        guard let (data, response) = try await urlSession.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              Self.validStatus.contains(response.statusCode) else {
            throw ClientError.networkError
        }
        return data
    }
    
    func item(with id: Int) async throws -> Item {
        let data = try await request(from: url(for: "/v0/item/\(id).json"))
        guard let decoded = try? decoder.decode(Item.self, from: data) else {
            throw ClientError.decodeError
        }
        return decoded
    }
    
    func stories(from endpoint: Endpoint) async throws -> [Int] {
        let data = try await request(from: url(for: endpoint.rawValue))
        guard let decoded = try? decoder.decode([Int].self, from: data) else {
            throw ClientError.decodeError
        }
        return decoded
    }
}
