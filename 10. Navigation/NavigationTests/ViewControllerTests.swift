//
//  ViewControllerTests.swift
//  NavigationTests
//
//  Created by RATAMATE on 09/11/21.
//

import XCTest

@testable import Navigation

class ViewControllerTests: XCTestCase {

    func test_outletsButton_shouldBeConnected(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.codeModalButton)
        XCTAssertNotNil(sut.codePushButton)
        XCTAssertNotNil(sut.segueModalButton)
        XCTAssertNotNil(sut.seguePushButton)


    }

}
