//
//  ViewControllerTests.swift
//  TextFieldTests
//
//  Created by RATAMATE on 14/11/21.
//

import Foundation
@testable import TextField
import XCTest

class ViewControllerTests: XCTestCase {

    private var sut: ViewController!
    
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
    
    func test_outlets_shouldBeConnected(){
       
        XCTAssertNotNil(sut.usernameField, "username field")
        XCTAssertNotNil(sut.passwordField, "password field")
    }
    
    func test_usernameField_attributesShouldBeSet(){
        let username = sut.usernameField!
        XCTAssertEqual(username.textContentType, .username, "textContentType")
        XCTAssertEqual(username.autocorrectionType, .no, "autocorrectionType")
        XCTAssertEqual(username.returnKeyType, .next, "returnKeyType")

    }
    
    func test_passwordField_attributesShouldBeSet(){
        let password = sut.passwordField!
        XCTAssertEqual(password.textContentType, .password, "textContentType")
        XCTAssertEqual(password.returnKeyType, .go, "returnKeyType")
        XCTAssertTrue(password.isSecureTextEntry, "isSecureTextEntry")
    }
}
