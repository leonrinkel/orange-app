//
//  ItemDecodeTests.swift
//  OrangeTests
//
//  Created by Leon Rinkel on 18.06.23.
//

import XCTest

@testable import Orange

final class ItemDecodeTests: XCTestCase {
    func testStoryDecode() throws {
        let json = """
            {
                "by" : "dhouston",
                "descendants" : 71,
                "id" : 8863,
                "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
                "score" : 111,
                "time" : 1175714200,
                "title" : "My YC app: Dropbox - Throw away your USB drive",
                "type" : "story",
                "url" : "http://www.getdropbox.com/u/2/screencast.html"
            }
        """
        let data = json.data(using: .utf8)!
        let decoded = try NewsApi.decoder.decode(Item.self, from: data)
        XCTAssertEqual(decoded.id, 8863)
        XCTAssertEqual(decoded.deleted, nil)
        XCTAssertEqual(decoded.type, .story)
        XCTAssertEqual(decoded.by, "dhouston")
        XCTAssertEqual(decoded.time, Date(timeIntervalSince1970: 1175714200))
        XCTAssertEqual(decoded.text, nil)
        XCTAssertEqual(decoded.dead, nil)
        XCTAssertEqual(decoded.parent, nil)
        XCTAssertEqual(decoded.poll, nil)
        XCTAssertEqual(decoded.kids, [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ])
        XCTAssertEqual(decoded.url, "http://www.getdropbox.com/u/2/screencast.html")
        XCTAssertEqual(decoded.parsedURL, URL(string: "http://www.getdropbox.com/u/2/screencast.html")!)
        XCTAssertEqual(decoded.score, 111)
        XCTAssertEqual(decoded.title, "My YC app: Dropbox - Throw away your USB drive")
        XCTAssertEqual(decoded.parts, nil)
        XCTAssertEqual(decoded.descendants, 71)
    }
    
    func testCommentDecode() throws {
        let json = """
            {
                "by" : "norvig",
                "id" : 2921983,
                "kids" : [ 2922097, 2922429, 2924562, 2922709, 2922573, 2922140, 2922141 ],
                "parent" : 2921506,
                "text" : "Aw shucks, guys ... you make me blush with your compliments.<p>Tell you what, Ill make a deal: I'll keep writing if you keep reading. K?",
                "time" : 1314211127,
                "type" : "comment"
            }
        """
        let data = json.data(using: .utf8)!
        let decoded = try NewsApi.decoder.decode(Item.self, from: data)
        XCTAssertEqual(decoded.id, 2921983)
        XCTAssertEqual(decoded.deleted, nil)
        XCTAssertEqual(decoded.type, .comment)
        XCTAssertEqual(decoded.by, "norvig")
        XCTAssertEqual(decoded.time, Date(timeIntervalSince1970: 1314211127))
        XCTAssertEqual(decoded.text, "Aw shucks, guys ... you make me blush with your compliments.<p>Tell you what, Ill make a deal: I'll keep writing if you keep reading. K?")
        XCTAssertEqual(decoded.dead, nil)
        XCTAssertEqual(decoded.parent, 2921506)
        XCTAssertEqual(decoded.poll, nil)
        XCTAssertEqual(decoded.kids, [ 2922097, 2922429, 2924562, 2922709, 2922573, 2922140, 2922141 ])
        XCTAssertEqual(decoded.url, nil)
        XCTAssertEqual(decoded.parsedURL, nil)
        XCTAssertEqual(decoded.score, nil)
        XCTAssertEqual(decoded.title, nil)
        XCTAssertEqual(decoded.parts, nil)
        XCTAssertEqual(decoded.descendants, nil)
    }
    
    func testAskDecode() throws {
        let json = """
            {
                "by" : "tel",
                "descendants" : 16,
                "id" : 121003,
                "kids" : [ 121016, 121109, 121168 ],
                "score" : 25,
                "text" : "<i>or</i> HN: the Next Iteration<p>I get the impression that with Arc being released a lot of people who never had time for HN before are suddenly dropping in more often. (PG: what are the numbers on this? I'm envisioning a spike.)<p>Not to say that isn't great, but I'm wary of Diggification. Between links comparing programming to sex and a flurry of gratuitous, ostentatious  adjectives in the headlines it's a bit concerning.<p>80% of the stuff that makes the front page is still pretty awesome, but what's in place to keep the signal/noise ratio high? Does the HN model still work as the community scales? What's in store for (++ HN)?",
                "time" : 1203647620,
                "title" : "Ask HN: The Arc Effect",
                "type" : "story"
            }
        """
        let data = json.data(using: .utf8)!
        let decoded = try NewsApi.decoder.decode(Item.self, from: data)
        XCTAssertEqual(decoded.id, 121003)
        XCTAssertEqual(decoded.deleted, nil)
        XCTAssertEqual(decoded.type, .story)
        XCTAssertEqual(decoded.by, "tel")
        XCTAssertEqual(decoded.time, Date(timeIntervalSince1970: 1203647620))
        XCTAssertEqual(decoded.text, "<i>or</i> HN: the Next Iteration<p>I get the impression that with Arc being released a lot of people who never had time for HN before are suddenly dropping in more often. (PG: what are the numbers on this? I'm envisioning a spike.)<p>Not to say that isn't great, but I'm wary of Diggification. Between links comparing programming to sex and a flurry of gratuitous, ostentatious  adjectives in the headlines it's a bit concerning.<p>80% of the stuff that makes the front page is still pretty awesome, but what's in place to keep the signal/noise ratio high? Does the HN model still work as the community scales? What's in store for (++ HN)?")
        XCTAssertEqual(decoded.dead, nil)
        XCTAssertEqual(decoded.parent, nil)
        XCTAssertEqual(decoded.poll, nil)
        XCTAssertEqual(decoded.kids, [ 121016, 121109, 121168 ])
        XCTAssertEqual(decoded.url, nil)
        XCTAssertEqual(decoded.parsedURL, nil)
        XCTAssertEqual(decoded.score, 25)
        XCTAssertEqual(decoded.title, "Ask HN: The Arc Effect")
        XCTAssertEqual(decoded.parts, nil)
        XCTAssertEqual(decoded.descendants, 16)
    }
    
    func testJobDecode() throws {
        let json = """
            {
                "by" : "justin",
                "id" : 192327,
                "score" : 6,
                "text" : "Justin.tv is the biggest live video site online. We serve hundreds of thousands of video streams a day, and have supported up to 50k live concurrent viewers. Our site is growing every week, and we just added a 10 gbps line to our colo. Our unique visitors are up 900% since January.<p>There are a lot of pieces that fit together to make Justin.tv work: our video cluster, IRC server, our web app, and our monitoring and search services, to name a few. A lot of our website is dependent on Flash, and we're looking for talented Flash Engineers who know AS2 and AS3 very well who want to be leaders in the development of our Flash.<p>Responsibilities<p><pre><code>    * Contribute to product design and implementation discussions\\n    * Implement projects from the idea phase to production\\n    * Test and iterate code before and after production release \\n</code></pre>\\nQualifications<p><pre><code>    * You should know AS2, AS3, and maybe a little be of Flex.\\n    * Experience building web applications.\\n    * A strong desire to work on website with passionate users and ideas for how to improve it.\\n    * Experience hacking video streams, python, Twisted or rails all a plus.\\n</code></pre>\\nWhile we're growing rapidly, Justin.tv is still a small, technology focused company, built by hackers for hackers. Seven of our ten person team are engineers or designers. We believe in rapid development, and push out new code releases every week. We're based in a beautiful office in the SOMA district of SF, one block from the caltrain station. If you want a fun job hacking on code that will touch a lot of people, JTV is for you.<p>Note: You must be physically present in SF to work for JTV. Completing the technical problem at <a href=\\"http://www.justin.tv/problems/bml\\" rel=\\"nofollow\\">http://www.justin.tv/problems/bml</a> will go a long way with us. Cheers!",
                "time" : 1210981217,
                "title" : "Justin.tv is looking for a Lead Flash Engineer!",
                "type" : "job",
                "url" : ""
            }
        """
        let data = json.data(using: .utf8)!
        let decoded = try NewsApi.decoder.decode(Item.self, from: data)
        XCTAssertEqual(decoded.id, 192327)
        XCTAssertEqual(decoded.deleted, nil)
        XCTAssertEqual(decoded.type, .job)
        XCTAssertEqual(decoded.by, "justin")
        XCTAssertEqual(decoded.time, Date(timeIntervalSince1970: 1210981217))
        XCTAssertEqual(decoded.text, "Justin.tv is the biggest live video site online. We serve hundreds of thousands of video streams a day, and have supported up to 50k live concurrent viewers. Our site is growing every week, and we just added a 10 gbps line to our colo. Our unique visitors are up 900% since January.<p>There are a lot of pieces that fit together to make Justin.tv work: our video cluster, IRC server, our web app, and our monitoring and search services, to name a few. A lot of our website is dependent on Flash, and we're looking for talented Flash Engineers who know AS2 and AS3 very well who want to be leaders in the development of our Flash.<p>Responsibilities<p><pre><code>    * Contribute to product design and implementation discussions\n    * Implement projects from the idea phase to production\n    * Test and iterate code before and after production release \n</code></pre>\nQualifications<p><pre><code>    * You should know AS2, AS3, and maybe a little be of Flex.\n    * Experience building web applications.\n    * A strong desire to work on website with passionate users and ideas for how to improve it.\n    * Experience hacking video streams, python, Twisted or rails all a plus.\n</code></pre>\nWhile we're growing rapidly, Justin.tv is still a small, technology focused company, built by hackers for hackers. Seven of our ten person team are engineers or designers. We believe in rapid development, and push out new code releases every week. We're based in a beautiful office in the SOMA district of SF, one block from the caltrain station. If you want a fun job hacking on code that will touch a lot of people, JTV is for you.<p>Note: You must be physically present in SF to work for JTV. Completing the technical problem at <a href=\"http://www.justin.tv/problems/bml\" rel=\"nofollow\">http://www.justin.tv/problems/bml</a> will go a long way with us. Cheers!")
        XCTAssertEqual(decoded.dead, nil)
        XCTAssertEqual(decoded.parent, nil)
        XCTAssertEqual(decoded.poll, nil)
        XCTAssertEqual(decoded.kids, nil)
        XCTAssertEqual(decoded.url, "")
        XCTAssertEqual(decoded.parsedURL, nil)
        XCTAssertEqual(decoded.score, 6)
        XCTAssertEqual(decoded.title, "Justin.tv is looking for a Lead Flash Engineer!")
        XCTAssertEqual(decoded.parts, nil)
        XCTAssertEqual(decoded.descendants, nil)
    }
    
    func testPollDecode() throws {
        let json = """
            {
                "by" : "pg",
                "descendants" : 54,
                "id" : 126809,
                "kids" : [ 126822, 126823, 126993, 126824, 126934, 127411, 126888, 127681, 126818, 126816, 126854, 127095, 126861, 127313, 127299, 126859, 126852, 126882, 126832, 127072, 127217, 126889, 127535, 126917, 126875 ],
                "parts" : [ 126810, 126811, 126812 ],
                "score" : 46,
                "text" : "",
                "time" : 1204403652,
                "title" : "Poll: What would happen if News.YC had explicit support for polls?",
                "type" : "poll"
            }
        """
        let data = json.data(using: .utf8)!
        let decoded = try NewsApi.decoder.decode(Item.self, from: data)
        XCTAssertEqual(decoded.id, 126809)
        XCTAssertEqual(decoded.deleted, nil)
        XCTAssertEqual(decoded.type, .poll)
        XCTAssertEqual(decoded.by, "pg")
        XCTAssertEqual(decoded.time, Date(timeIntervalSince1970: 1204403652))
        XCTAssertEqual(decoded.text, "")
        XCTAssertEqual(decoded.dead, nil)
        XCTAssertEqual(decoded.parent, nil)
        XCTAssertEqual(decoded.poll, nil)
        XCTAssertEqual(decoded.kids, [ 126822, 126823, 126993, 126824, 126934, 127411, 126888, 127681, 126818, 126816, 126854, 127095, 126861, 127313, 127299, 126859, 126852, 126882, 126832, 127072, 127217, 126889, 127535, 126917, 126875 ])
        XCTAssertEqual(decoded.url, nil)
        XCTAssertEqual(decoded.parsedURL, nil)
        XCTAssertEqual(decoded.score, 46)
        XCTAssertEqual(decoded.title, "Poll: What would happen if News.YC had explicit support for polls?")
        XCTAssertEqual(decoded.parts, [ 126810, 126811, 126812 ])
        XCTAssertEqual(decoded.descendants, 54)
    }
    
    func testPolloptDecode() throws {
        let json = """
            {
                "by" : "pg",
                "id" : 160705,
                "poll" : 160704,
                "score" : 335,
                "text" : "Yes, ban them; I'm tired of seeing Valleywag stories on News.YC.",
                "time" : 1207886576,
                "type" : "pollopt"
            }
        """
        let data = json.data(using: .utf8)!
        let decoded = try NewsApi.decoder.decode(Item.self, from: data)
        XCTAssertEqual(decoded.id, 160705)
        XCTAssertEqual(decoded.deleted, nil)
        XCTAssertEqual(decoded.type, .pollopt)
        XCTAssertEqual(decoded.by, "pg")
        XCTAssertEqual(decoded.time, Date(timeIntervalSince1970: 1207886576))
        XCTAssertEqual(decoded.text, "Yes, ban them; I'm tired of seeing Valleywag stories on News.YC.")
        XCTAssertEqual(decoded.dead, nil)
        XCTAssertEqual(decoded.parent, nil)
        XCTAssertEqual(decoded.poll, 160704)
        XCTAssertEqual(decoded.kids, nil)
        XCTAssertEqual(decoded.url, nil)
        XCTAssertEqual(decoded.parsedURL, nil)
        XCTAssertEqual(decoded.score, 335)
        XCTAssertEqual(decoded.title, nil)
        XCTAssertEqual(decoded.parts, nil)
        XCTAssertEqual(decoded.descendants, nil)
    }
}
