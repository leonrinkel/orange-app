//
//  NewsApiTests.swift
//  OrangeTests
//
//  Created by Leon Rinkel on 29.06.23.
//

import XCTest

@testable import Orange

final class NewsApiTests: XCTestCase {
    func testUrl() throws {
        XCTAssertEqual(
            NewsApi.url(for: NewsApi.List.topStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json")
        )
        XCTAssertEqual(
            NewsApi.url(for: NewsApi.List.newStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/newstories.json")
        )
        XCTAssertEqual(
            NewsApi.url(for: NewsApi.List.bestStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/beststories.json")
        )
        XCTAssertEqual(
            NewsApi.url(for: NewsApi.List.askStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/askstories.json")
        )
        XCTAssertEqual(
            NewsApi.url(for: NewsApi.List.showStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/showstories.json")
        )
        XCTAssertEqual(
            NewsApi.url(for: NewsApi.List.jobStories.rawValue),
            URL(string: "https://hacker-news.firebaseio.com/v0/jobstories.json")
        )
    }
}
