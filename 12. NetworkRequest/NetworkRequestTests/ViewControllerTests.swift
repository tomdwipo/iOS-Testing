//
//  ViewControllerTests.swift
//  NetworkRequestTests
//
//  Created by RATAMATE on 11/11/21.
//

import XCTest
@testable import NetworkRequest

class ViewControllerTests: XCTestCase {
    var sut: ViewController!
   
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
    
    func test_tappingButton_shouldBeConnected(){
        sut.loadViewIfNeeded()
        
        tap(sut.button)
    }
    
    func test_tappingButton_requestShouldBeCallOnce(){
        let mockUrlSession = MockUrlSession()
        sut.session = mockUrlSession
        sut.loadViewIfNeeded()
        
        tap(sut.button)
        XCTAssertEqual(mockUrlSession.dataTaskCallCount, 1, "Call count")
    }
    
    
    func test_tappingButton_urlShouldToItunesAppleUrl(){
        let mockUrlSession = MockUrlSession()
        sut.session = mockUrlSession
        sut.loadViewIfNeeded()
        
        tap(sut.button)
        
        XCTAssertEqual(mockUrlSession.dataTaskArgsRequest.first , URLRequest(url: URL(string: "https://itunes.apple.com/search?media=ebook&term=out%20from%20boneville")!) , "request")
    }
    
    
    
}
