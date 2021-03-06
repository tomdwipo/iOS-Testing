//
//  CoveredClassTests.swift
//  CodeCoverageTests
//
//  Created by RATAMATE on 07/11/21.
//

import XCTest
@testable import CodeCoverage

class CoveredClassTests: XCTestCase {

    //MARK: Cover a Condition
    func test_max_with1And2_shouldReturn2(){
        let result = CoveredClass.max(1, 2)
        XCTAssertEqual(result, 2)
    }
    
    func test_max_with3And2_shouldReturn3(){
        let result = CoveredClass.max(3, 2)
        XCTAssertEqual(result, 3)
    }
    
    //MARK: Cover a Lopp
    func test_commaSeparated_from2to4_shouldReturn234SeparatedByComma(){
        let result = CoveredClass.commaSeparated(from: 2, to: 4)
        XCTAssertEqual(result, "2,3,4")
    }
    
    func test_commaSeparated_from2to2_shouldReturn2WithNoComma(){
        let result = CoveredClass.commaSeparated(from: 2, to: 2)
        XCTAssertEqual(result, "2")
    }
    
    //MARK: Cover a sequence
    func test_area_withWidth7_shouldReturnBe49(){
        let sut = CoveredClass()
        
        sut.width = 7
        
        XCTAssertEqual(sut.area, 49)
    }
}
