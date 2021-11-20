//
//  ChangePasswordViewControllerTests.swift
//  RefactoringTests
//
//  Created by RATAMATE on 20/11/21.
//

import Foundation
@testable import Refactoring
import XCTest
import ViewControllerPresentationSpy


final class ChangePasswordViewControllerTests: XCTestCase {
    private var sut: ChangePasswordViewController!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(withIdentifier: String(describing: ChangePasswordViewController.self)) as? ChangePasswordViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        executeRunLoop()
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
    
    private func putFocusOn(textField: UITextField) {
        putViewInHierarchy(sut)
        textField.becomeFirstResponder()
    }
    
    func test_tappingCancel_withFocusOnOldPassword_shouldResignThatFocus(){
        putFocusOn(textField: sut.oldPasswordTextField)
        XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder, "precondition")
        
        tap(sut.cancelBarButton)
        
        XCTAssertFalse(sut.oldPasswordTextField.isFirstResponder)
    }
    
    func test_tappingCancel_withFocusOnNewPassword_shouldResignThatFocus(){
        putFocusOn(textField: sut.newPasswordTextField)
        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
        
        tap(sut.cancelBarButton)
        
        XCTAssertFalse(sut.newPasswordTextField.isFirstResponder)
    }
    
    func test_tappingCancel_withFocusOnConfirmPassword_shouldResignThatFocus(){
        putFocusOn(textField: sut.confirmPasswordTextField)
        XCTAssertTrue(sut.confirmPasswordTextField.isFirstResponder)
        
        tap(sut.cancelBarButton)
        
        XCTAssertFalse(sut.confirmPasswordTextField.isFirstResponder)
    }
    
    func test_tappingCancel_shouldDismissModal(){
        let dismissalVerifier = DismissalVerifier()
        tap(sut.cancelBarButton)
        dismissalVerifier.verify(animated: true, dismissedViewController: sut)
    }
}

