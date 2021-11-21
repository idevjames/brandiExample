//
//  brandiExampleTests.swift
//  brandiExampleTests
//
//  Created by HooGi on 2021/11/17.
//

import XCTest
@testable import brandiExample

class brandiExampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let dateString = "2016-04-15T00:50:00.000+00:00"
        let date = dateString.toDate()
        
        print(date!)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
