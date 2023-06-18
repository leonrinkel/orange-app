//
//  NewsClientTests.swift
//  OrangeTests
//
//  Created by Leon Rinkel on 18.06.23.
//

import XCTest

@testable import Orange

final class NewsClientTests: XCTestCase {
    private var client: NewsClient?

    override func setUpWithError() throws {
        client = .init()
    }

    override func tearDownWithError() throws {
        client = nil
    }

    func testUrl() throws {
        XCTAssertEqual(
            client?.url(for: NewsClient.Endpoint.maxItem.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/maxitem.json")
        )
        XCTAssertEqual(
            client?.url(for: NewsClient.Endpoint.topStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json")
        )
        XCTAssertEqual(
            client?.url(for: NewsClient.Endpoint.newStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/newstories.json")
        )
        XCTAssertEqual(
            client?.url(for: NewsClient.Endpoint.bestStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/beststories.json")
        )
        XCTAssertEqual(
            client?.url(for: NewsClient.Endpoint.askStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/askstories.json")
        )
        XCTAssertEqual(
            client?.url(for: NewsClient.Endpoint.showStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/showstories.json")
        )
        XCTAssertEqual(
            client?.url(for: NewsClient.Endpoint.jobStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/jobstories.json")
        )
        XCTAssertEqual(
            client?.url(for: NewsClient.Endpoint.updates.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/updates.json")
        )
    }
}
