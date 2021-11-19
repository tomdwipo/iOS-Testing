//
//  ViewControllerTests.swift
//  UserDefaultsTests
//
//  Created by RATAMATE on 10/11/21.
//

import XCTest
@testable import UserDefaults

class ViewControllerTests: XCTestCase {
    private var sut: ViewController!
    private var defaults: FakeUserDefaults!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        defaults = FakeUserDefaults()
        sut.userDefaults = defaults
    }
    
    override func tearDown() {
        sut = nil
        defaults = nil
        super.tearDown()
    }
    
    func test_outlets_shouldConnected(){
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.counterLabel)
        XCTAssertNotNil(sut.incrementButton)
    }
    
    func test_viewDidload_withEmptyUserDefaults_shouldShow0InCounterLabel(){
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.counterLabel.text, "0")
    }
    
    func test_button_shouldBeCanTapping(){
        sut.loadViewIfNeeded()

        tap(sut.incrementButton)
        
    }
    
    func test_viewDidload_with7UserDefaults_shouldShow7InCounterLabel(){
        defaults.integers = ["count": 7]
        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.counterLabel.text, "7")
    }
    
    func test_tappingButton_with12InUserDefaults_shouldShow13InCounterLabel(){
        defaults.integers = ["count": 12]
        sut.loadViewIfNeeded()
        tap(sut.incrementButton)
        
        XCTAssertEqual(defaults.integers["count"], 13)
    }
    
    func test_tappingButton_with43InUserDefaults_shouldShow44InCounterLabel(){
        defaults.integers = ["count": 43]
        sut.loadViewIfNeeded()
        tap(sut.incrementButton)
        
        XCTAssertEqual(defaults.integers["count"], 44)
    }
}
