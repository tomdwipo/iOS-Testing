//
//  ViewControllerTests.swift
//  AlertTests
//
//  Created by RATAMATE on 09/11/21.
//

import XCTest
import ViewControllerPresentationSpy
@testable import Alert

class ViewControllerTests: XCTestCase {
    private var alertVerifier: AlertVerifier!
    private var sut: ViewController!
    
    override func setUp() {
        super.setUp()

        alertVerifier = AlertVerifier()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        alertVerifier = nil
        sut = nil
        super.tearDown()
    }
    
    func test_outlets_shouldBeConnected(){
        XCTAssertNotNil(sut.button, "button")
    }
    
    func test_tapingButton_shouldShowAlert(){
      
        tap(sut.button)
        alertVerifier.verify(title: "Do the thing?", message: "Let us know if you want to do thing", animated: true, actions: [.cancel("Cancel"), .default("OK")], presentingViewController: sut)

        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK", "prefered action")
    }
    
    func test_executeAlertAction_withOkButton() throws {
        tap(sut.button)
        try alertVerifier.executeAction(forButton: "OK")
    }
}
