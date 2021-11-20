//
//  ChangePasswordViewControllerTests.swift
//  RefactoringTests
//
//  Created by RATAMATE on 20/11/21.
//

import Foundation
@testable import Refactoring
import XCTest

final class ChangePasswordViewControllerTests: XCTestCase {
    private var sut: ChangePasswordViewController!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(withIdentifier: String(describing: ChangePasswordViewController.self)) as? ChangePasswordViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_outlets_shouldBeConnected(){
        XCTAssertNotNil(sut.cancelBarButton, "cancel button")
        XCTAssertNotNil(sut.oldPasswordTextField, "oldPasswordTextField")
        XCTAssertNotNil(sut.newPasswordTextField, "newPasswordTextField")
        XCTAssertNotNil(sut.confirmPasswordTextField, "confirmPasswordTextField")
        XCTAssertNotNil(sut.submitButton, "submitButton")
        XCTAssertNotNil(sut.navigationBar)
    }
    
    func test_navigationBar_shouldHaveTitle(){
        XCTAssertEqual(sut.navigationBar.topItem?.title, "Change Password")
    }
    
    func test_cancelBarButton_shouldBeSystemItemCancel(){
        XCTAssertEqual(systemItem(for: sut.cancelBarButton), .cancel)
    }
    
    func test_oldPasswordTextField_shouldHavePlaceholder(){
        XCTAssertEqual(sut.oldPasswordTextField.placeholder, "Current Password")
    }
    
    func test_newPasswordTextField_shouldHavePlaceHolder(){
        XCTAssertEqual(sut.newPasswordTextField.placeholder, "New Password")
    }
    
    func test_confirmPasswordTextField_shouldHavePlaceHolder(){
        XCTAssertEqual(sut.confirmPasswordTextField.placeholder, "Confirm New Password")
    }
    
    func test_submitButton_shouldHaveTitle(){
        XCTAssertEqual(sut.submitButton.titleLabel?.text, "Submit")
    }
    
    func test_oldPasswordTextField_shouldHavePasswordAttributes(){
        let textfield = sut.oldPasswordTextField!
        XCTAssertEqual(textfield.textContentType, .password, "textContentType")
        XCTAssertTrue(textfield.isSecureTextEntry, "isSecureTextEntry")
        XCTAssertTrue(textfield.enablesReturnKeyAutomatically, "enablesReturnKeyAutomatically")
    }
    
    func test_NewPasswordTextField_shouldHavePasswordAttributes(){
        let textfield = sut.newPasswordTextField!
        XCTAssertEqual(textfield.textContentType, .newPassword, "textContentType")
        XCTAssertTrue(textfield.isSecureTextEntry, "isSecureTextEntry")
        XCTAssertTrue(textfield.enablesReturnKeyAutomatically, "enablesReturnKeyAutomatically")
    }
    
    func test_ConfirmPasswordTextField_shouldHavePasswordAttributes(){
        let textfield = sut.confirmPasswordTextField!
        XCTAssertEqual(textfield.textContentType, .newPassword, "textContentType")
        XCTAssertTrue(textfield.isSecureTextEntry, "isSecureTextEntry")
        XCTAssertTrue(textfield.enablesReturnKeyAutomatically, "enablesReturnKeyAutomatically")
    }
}

