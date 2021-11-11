//
//  ViewControllerTests.swift
//  NetworkRequestTests
//
//  Created by RATAMATE on 11/11/21.
//

import XCTest
@testable import NetworkRequest

class ViewControllerTests: XCTestCase {
    
    func test_outlet_shouldBeConnected(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.button)
    }
    
    func test_tappingButton_shouldBeConnected(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        
        sut.loadViewIfNeeded()
        
        tap(sut.button)
    }
}
