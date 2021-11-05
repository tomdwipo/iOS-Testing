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
//        XCTFail()
    }
    
    func test_fail_withSimpleMessage(){
        XCTFail("we have a problem")
    }
}
