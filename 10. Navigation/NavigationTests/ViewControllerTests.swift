//
//  ViewControllerTests.swift
//  NavigationTests
//
//  Created by RATAMATE on 09/11/21.
//

import XCTest
import ViewControllerPresentationSpy

@testable import Navigation

class ViewControllerTests: XCTestCase {
    private var sut : ViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        sut.loadViewIfNeeded()

    }
    
    override func tearDown() {
        executeRunLoop()
        sut = nil
        super.tearDown()
    }
    func test_outletsButton_shouldBeConnected(){
      
        XCTAssertNotNil(sut.codeModalButton)
        XCTAssertNotNil(sut.codePushButton)
        XCTAssertNotNil(sut.segueModalButton)
        XCTAssertNotNil(sut.seguePushButton)
    }
    
    func test_tappingCodePushButton_shouldPushCodeNextViewController(){
       
        let navigation = SpyNavigationController(rootViewController: sut)
        
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
        
        XCTAssertEqual(navigation.pushViewControllerArgsAnimated.last, true, "push view argument isAnimated")
    }
    
    //MARK: Dont recommended
    func test_INCORRECT_tappingCodeModalButton_shouldPresentCodeNextViewController(){
        
        UIApplication.shared.windows.first?.rootViewController = sut
        tap(sut.codeModalButton)
        let presentVC = sut.presentedViewController
        guard let codeNextVC = presentVC as? CodeNextViewController else {
            XCTFail("Expected CodeNextViewController, " + "but was \(String(describing: presentVC))")
            return
        }
        XCTAssertEqual(codeNextVC.label.text, "Modal from code")
        
    }

    func test_tappingCodeModalButton_shouldPresentCodeNextViewController(){

        let presentationVerifier = PresentationVerifier()
       
        tap(sut.codeModalButton)
      
        let codeNextVC: CodeNextViewController? = presentationVerifier.verify(animated: true, presentingViewController: sut)
      
        XCTAssertEqual(codeNextVC?.label.text, "Modal from code")
        
    }
    
    func test_tappingSeguePushButton_shouldShowCodeNextViewController(){

        let presentationVerifier = PresentationVerifier()

        putInWindow(sut)

        tap(sut.seguePushButton)
      
        executeRunLoop()

        
        let codeNextVC: SegueNextViewController? = presentationVerifier.verify(animated: true, presentingViewController: sut)
  
          XCTAssertEqual(codeNextVC?.label.text, "Pushed from segue")
    }
    
    func test_tappingSegueModalButton_shouldShowSegueNextViewController(){
        let presentationVerifier = PresentationVerifier()
        
        tap(sut.segueModalButton)
        
        let segueNextVC: SegueNextViewController? = presentationVerifier.verify(animated: true, presentingViewController: sut)

        XCTAssertEqual(segueNextVC?.label.text, "Modal from segue")

    }
}
