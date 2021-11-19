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
    
    func test_textFieldDelegates_shouldBeConnected(){
        XCTAssertNotNil(sut.usernameField.delegate, "username delegate")
        XCTAssertNotNil(sut.passwordField.delegate, "password delegate")
    }
    
    func test_shouldChangeCharacters_usernameWithSpace_shouldPreventChange(){
        let allowChange = shouldChangeCharacters(in: sut.usernameField, replacement: "a b")
        XCTAssertEqual(allowChange, false)
    }
    
    func test_shouldChangeCharacters_usernameWithOutSpace_shouldAllowChange(){
        let allowChange = shouldChangeCharacters(in: sut.usernameField, replacement: "ab")
        XCTAssertEqual(allowChange, true)
    }
    
    func test_shouldChangeCharacters_passwordWithSpace_shouldAllowChange(){
        let allowChange = shouldChangeCharacters(in: sut.passwordField, replacement: "a b")
        XCTAssertEqual(allowChange, true)
    }
    
    func test_shouldChangeCharacters_passwordWithOutSpace_shouldAllowChange(){
        let allowChange = shouldChangeCharacters(in: sut.passwordField, replacement: "ab")
        XCTAssertEqual(allowChange, true)
    }
    
    func test_shouldReturn_withPassword_shouldPerformLogin(){
        sut.usernameField.text = "USERNAME"
        sut.passwordField.text = "PASSWORD"
        
        shouldReturn(in: sut.passwordField)
    }
    
    func test_shouldReturn_withUsername_shouldMoveInputFocusToPassword(){
        putInViewHierarchy(sut)
        shouldReturn(in: sut.usernameField)
        XCTAssertTrue(sut.passwordField.isFirstResponder)
    }
    
    func test_shouldReturn_withPassword_shouldDismissKeyboard(){
        putInViewHierarchy(sut)
        sut.passwordField.becomeFirstResponder()
        XCTAssertTrue(sut.passwordField.isFirstResponder, "precondition")
        shouldReturn(in: sut.passwordField)
        XCTAssertFalse(sut.passwordField.isFirstResponder)
    }
}
