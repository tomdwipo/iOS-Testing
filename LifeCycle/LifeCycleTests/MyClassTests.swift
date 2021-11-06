//
//  MyClassTests.swift
//  LifeCycleTests
//
//  Created by RATAMATE on 06/11/21.
//

import XCTest
@testable import LifeCycle

class MyClassTests: XCTestCase {

    //MARK: after infra is okay delete them
//    func test_zero(){
//        XCTFail("Tests not yet implemented in MyClassTests")
//    }
    
    func test_methodOne(){
        let sut = MyClass()
        
        sut.methodOne()
        
        XCTFail("Failed, ya")
    }
    
    func test_methodTwo(){
        let sut = MyClass()
        
        sut.methodTwo()
        
    }

}
