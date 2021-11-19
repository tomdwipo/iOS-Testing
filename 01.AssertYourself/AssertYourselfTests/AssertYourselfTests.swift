//
//  AssertYourselfTests.swift
//  AssertYourselfTests
//
//  Created by RATAMATE on 05/11/21.
//

import XCTest
@testable import AssertYourself

class AssertYourselfTests: XCTestCase {
//    func test_fail(){
//        XCTFail()
//    }
    
//    func test_fail_withSimpleMessage(){
//        XCTFail("we have a problem")
//    }
    
//    func test_fail_withInterpolatedMessage(){
//        let theAnswer = 40
//        XCTFail("the answer is \(theAnswer)")
//    }
    
    //MARK: Don't do this!
    func test_fail_avoidConditionalCode(){
        
        let success = true
        if !success {
            XCTFail()
        }
    }
    
    //MARK: Do this!
    func test_fail_asserttrue(){
        measure {
            let success = true
            XCTAssertTrue(success)
        }
       
    }
//
//    func test_assertNil(){
//        let optionalValue: Int? = 20
//        XCTAssertNil(optionalValue)
//    }
//
//    func test_assertNil_withSimpleStruct(){
//        let optionalValue: SimpleStruct? = SimpleStruct(x: 1, y: 2)
//        XCTAssertNil(optionalValue)
//    }
//
//    func test_assertNil_withSelfDescribingType(){
//        let optionalValue: StructWithDescribing? = StructWithDescribing(x: 1, y: 2)
//        XCTAssertNil(optionalValue)
//    }
//
//    func test_assertEqual(){
//        let actual = "actual"
//        XCTAssertEqual(actual, "expected")
//    }
//
//    func test_assertEqual_withOptional(){
//        let result: String? = "foo"
//        XCTAssertEqual(result, "bar")
//    }
//
//    func test_floatingPointDanger(){
//        let result = 0.1 + 0.2
//        XCTAssertEqual(result, 0.3)
//    }
    
    func test_floatingPointFixed(){
        let result = 0.1 + 0.2
        XCTAssertEqual(result, 0.3, accuracy: 0.0001)
    }
    
//    func test_messageOverKill(){
//        let actual = "Actual"
//        XCTAssertEqual(actual, "expected", "expected \"expected\" but got \"\(actual)\"")
//    }
}

struct SimpleStruct {
    let x: Int
    let y: Int
    
}


struct StructWithDescribing: CustomStringConvertible {
    let x: Int
    let y: Int
    
    var description: String { "value x: \(x) and y: \(y)"}
}

