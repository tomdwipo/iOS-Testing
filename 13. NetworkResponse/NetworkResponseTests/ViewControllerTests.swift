//
//  ViewControllerTests.swift
//  NetworkResponseTests
//
//  Created by RATAMATE on 12/11/21.
//

import XCTest

@testable import NetworkResponse

class ViewControllerTest: XCTestCase {
    private var sut: ViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_outlet_shouldBeConnected(){
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.button)
    }
    
    func test_button_shouldBeTapped(){
        sut.loadViewIfNeeded()
        tap(sut.button)
    }
    
}
