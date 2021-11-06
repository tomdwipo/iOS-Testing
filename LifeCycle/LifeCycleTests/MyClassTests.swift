//
//  MyClassTests.swift
//  LifeCycleTests
//
//  Created by RATAMATE on 06/11/21.
//

import XCTest
@testable import LifeCycle

class MyClassTests: XCTestCase {
    private var sut: MyClass!

    //MARK: after infra is okay delete them
//    func test_zero(){
//        XCTFail("Tests not yet implemented in MyClassTests")
//    }
    
    override func setUp() {
        super.setUp()
        sut = MyClass()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_methodOne(){
        sut.methodOne()
        
//        XCTFail("Failed, ya")
    }
    
    func test_methodTwo(){
        
        sut.methodTwo()
        
    }

}
