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
    
    func test_searchForNetworkCall_withSuccessResponse_shouldSaveDataInResults(){
        let spyURLSession = SpyURLSession()
        sut.session = spyURLSession
        
        sut.loadViewIfNeeded()
        tap(sut.button)
        
        let handleResultCalled = expectation(description: "handleResult called")
        sut.handleResults = { _ in handleResultCalled.fulfill() }
        
        spyURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        waitForExpectations(timeout: 0.01)

        XCTAssertEqual(sut.results, [SearchResult(artistName: "Artist", trackName: "Track", averageUserRating: 2.5, genres: ["Foo", "Bar"])])
    }
    
    func test_searchForNetworkCall_withSuccessBeforeAsync_shouldNotSaveDataInResults(){
        let spyURLSession = SpyURLSession()
        sut.session = spyURLSession
        
        sut.loadViewIfNeeded()
        tap(sut.button)
        spyURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        XCTAssertEqual(sut.results, [])


        
    }
    
    private func jsonData() -> Data {
        """
       {
         "results": [
           {
             "artistName": "Artist",
             "trackName": "Track",
             "averageUserRating": 2.5,
             "genres": [
               "Foo",
               "Bar"
             ]
           }
         ]
       }
""".data(using: String.Encoding.utf8)!
    }
    
    private func response(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "https://DUMMY")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
    }
    
}
