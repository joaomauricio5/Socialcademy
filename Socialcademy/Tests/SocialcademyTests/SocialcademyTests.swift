//
//  SocialcademyTests.swift
//  SocialcademyTests
//
//  Created by Joao Mauricio on 22/05/2022.
//

import XCTest
@testable import Socialcademy

class SocialcademyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPostContains() throws {
        let Post = Post(title: "tItLE,.13@£!", content: "CONTENT", authorName: "content", timestamp: Date())
        XCTAssert(Post.contains("CONTENT"))
        XCTAssert(Post.contains("CONT"))
        XCTAssert(Post.contains("conTEnT"))
        XCTAssert(Post.contains("content"))
        XCTAssert(Post.contains("title"))
        XCTAssert(Post.contains("    title     "))
        XCTAssertFalse(Post.contains("Test..."))
        XCTAssertFalse(Post.contains("CONTENTE"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
