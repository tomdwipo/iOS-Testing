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
    
    func test_tappingCodePushButton_shouldPushCodeNextViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        sut.loadViewIfNeeded()
        let navigation = UINavigationController(rootViewController: sut)
        
        tap(sut.codePushButton)
        
        XCTAssertNotNil(sut.navigationController)
      
        executeRunLoop()
       
        XCTAssertEqual(navigation.viewControllers.count, 2, "navigation stack")
        
        
        let pushedVC = navigation.viewControllers.last
       
        XCTAssertTrue(pushedVC is CodeNextViewController, "Expected CodeNextViewController, " + "but was \(String(describing: pushedVC))")

        guard let codeNextVC = pushedVC as? CodeNextViewController else {  XCTFail("Expected CodeNextViewController, " + "but was \(String(describing: pushedVC))")
            return
        }
        
        XCTAssertEqual(codeNextVC.label.text, "Pushed from code")
    }

}
