//
//  ViewControllerTests.swift
//  NetworkResponseTests
//
//  Created by RATAMATE on 12/11/21.
//

import XCTest
import ViewControllerPresentationSpy

@testable import NetworkResponse

class ViewControllerTest: XCTestCase {
    private var sut: ViewController!
    private var alertVerifier: AlertVerifier!
    private var spyURLSession: SpyURLSession!
    
    override func setUp() {
        super.setUp()
        alertVerifier = AlertVerifier()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        spyURLSession = SpyURLSession()
        sut.session = spyURLSession
        sut.loadViewIfNeeded()

    }
    
    override func tearDown() {
        sut = nil
        alertVerifier = nil
        spyURLSession = nil
        super.tearDown()
    }
    
    func test_outlet_shouldBeConnected(){
        XCTAssertNotNil(sut.button)
    }
    
    func test_button_shouldBeTapped(){
        tap(sut.button)
    }
    
    func test_searchForNetworkCall_withSuccessResponse_shouldSaveDataInResults(){
     
        tap(sut.button)
        
        let handleResultCalled = expectation(description: "handleResult called")
        sut.handleResults = { _ in handleResultCalled.fulfill() }
        
        spyURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        
        waitForExpectations(timeout: 0.01)

        XCTAssertEqual(sut.results, [SearchResult(artistName: "Artist", trackName: "Track", averageUserRating: 2.5, genres: ["Foo", "Bar"])])
    }
    
    func test_searchForNetworkCall_withSuccessBeforeAsync_shouldNotSaveDataInResults(){
    
        tap(sut.button)
        spyURLSession.dataTaskArgsCompletionHandler.first?(jsonData(), response(statusCode: 200), nil)
        XCTAssertEqual(sut.results, [])
    }
    
    func test_searchForBookNetworkCall_withError_shouldShowAlert(){
        tap(sut.button)
        let alertShown = expectation(description: "alert shown")
        alertVerifier.testCompletion = {
            alertShown.fulfill()
        }
        spyURLSession.dataTaskArgsCompletionHandler.first?(nil  , nil, TestError(message: "oh no"))
        waitForExpectations(timeout: 0.01)
        verifyErrorAlert(message: "oh no")
        
    }
    
    func test_searchForBookNetworkCall_withErrorPreAsycn_shouldNotShowAlert(){
        tap(sut.button)
      
        spyURLSession.dataTaskArgsCompletionHandler.first?(nil  , nil, TestError(message: "oh no"))
        XCTAssertEqual(alertVerifier.presentedCount, 0)
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
    
    private func verifyErrorAlert(message: String, file: StaticString = #file, line: UInt = #line){
        alertVerifier.verify(title: "Network problem", message: message, animated: true, actions: [AlertVerifier.Action.default("OK")], presentingViewController: sut, file: file, line: line)
        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK", "preferred action", file: file, line: line)
    }
    
}
