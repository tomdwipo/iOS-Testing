//
//  AssertYourselfTests.swift
//  AssertYourselfTests
//
//  Created by RATAMATE on 05/11/21.
//

import XCTest
@testable import AssertYourself

class AssertYourselfTests: XCTestCase {
    func test_fail(){
        XCTFail()
    }
    
    func test_fail_withSimpleMessage(){
        XCTFail("we have a problem")
    }
    
    func test_fail_withInterpolatedMessage(){
        let theAnswer = 40
        XCTFail("the answer is \(theAnswer)")
    }
    
    //MARK: Don't do this!
    func test_fail_avoidConditionalCode(){
        let success = true
        if !success {
            XCTFail()
        }
    }
    
    //MARK: Do this!
    func test_fail_asserttrue(){
        let success = true
        XCTAssertTrue(success)
    }
}
