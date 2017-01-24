//
//  AppUIKitTests.swift
//  AppUIKitTests
//
//  Created by ricky on 2016. 11. 29..
//  Copyright © 2016년 appcid. All rights reserved.
//

import XCTest
@testable import AppUIKit

class AppUIKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAUIControlState() {
        let controlState: AUIControlState = [.normal, .highlighted]
        XCTAssertTrue(controlState.contains(.normal))
        XCTAssertTrue(controlState.contains(.highlighted))
        
        let controlState2: AUIControlState = .highlighted
        XCTAssertTrue(controlState2.contains(.highlighted))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
