//
//  ChangePasswordViewControllerTests.swift
//  RefactoringTests
//
//  Created by RATAMATE on 20/11/21.
//

import Foundation
@testable import MVVM
import XCTest
import ViewControllerPresentationSpy


final class ChangePasswordViewControllerTests: XCTestCase {
    private var sut: ChangePasswordViewController!
    private var passwordChanger: MockPasswordChanger!
    private var alertVerifier: AlertVerifier!
    
    override func setUp() {
        super.setUp()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(withIdentifier: String(describing: ChangePasswordViewController.self)) as? ChangePasswordViewController
        
        passwordChanger = MockPasswordChanger()
        sut.passwordChanger = passwordChanger
        alertVerifier = AlertVerifier()
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        executeRunLoop()
        sut = nil
        passwordChanger = nil
        alertVerifier = nil
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
    
    private func setUpValidPasswordEntries(){
        sut.oldPasswordTextField.text = "NONEMPTY"
        sut.newPasswordTextField.text = "123456"
        sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
    }
    
    func test_tappingSubmit_withOldPasswordEmpty_shouldNotChangePassword(){
        setUpValidPasswordEntries()
        sut.oldPasswordTextField.text = ""
        
        tap(sut.submitButton)
        
        passwordChanger.verifyChangeNeverCalled()
    }
    
    func test_tappingSubmit_withOldPasswordEmpty_shouldPutFocusOnOldPassword(){
        setUpValidPasswordEntries()
        sut.oldPasswordTextField.text = ""
        
        putViewInHierarchy(sut)
        
        tap(sut.submitButton)
        
        XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder)
    }
    
    private func verifyAlertPresented(message: String, file: StaticString = #file, line: UInt = #line) {
        alertVerifier.verify(title: nil, message: message, animated: true, actions: [AlertVerifier.Action.default("OK")], presentingViewController: sut, file: file, line: line)
        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK", "preferred action", file:file, line: line)
    }
    
    func test_tappingSubmit_withNewPasswordEmpty_shouldNotChangePassword(){
        setUpValidPasswordEntries()
        sut.newPasswordTextField.text = ""
        
        putViewInHierarchy(sut)
        
        tap(sut.submitButton)
        
        passwordChanger.verifyChangeNeverCalled()
    }
    
    func test_tappingSubmit_withNewPasswordEmpty_shouldShowPasswordBlankAlert(){
        setUpValidPasswordEntries()
        sut.newPasswordTextField.text = ""
        
        putViewInHierarchy(sut)
        
        tap(sut.submitButton)
        
        verifyAlertPresented(message: "Please enter a New Password.")
    }
    
    func test_tappingOKPasswordAlert_shouldFocusOnNewPassword() throws {
        setUpValidPasswordEntries()
        sut.newPasswordTextField.text = ""
        tap(sut.submitButton)
        putViewInHierarchy(sut)
        try alertVerifier.executeAction(forButton: "OK")
        
        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
    }
    
    private func setUpEntriesNewPasswordTooShort(){
        sut.oldPasswordTextField.text = "NONEMPTY"
        sut.newPasswordTextField.text = "12345"
        sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
    }
    
    func test_tappingSubmit_withNewPasswordTooShort_shouldNotChangePassword(){
        setUpEntriesNewPasswordTooShort()
        tap(sut.submitButton)
        passwordChanger.verifyChangeNeverCalled()
    }
    
    func test_tappingSubmit_withNewPasswordTooShort_shouldShowTooShortAlert(){
        setUpEntriesNewPasswordTooShort()
        tap(sut.submitButton)
        verifyAlertPresented(message: "The new password should have at least 6 characters.")
    }
    
    func test_tappingOKInTooShortAlert_shouldClearNewAndConfirmation() throws {
        setUpEntriesNewPasswordTooShort()
        tap(sut.submitButton)
        try alertVerifier.executeAction(forButton: "OK")
        
        XCTAssertEqual(sut.newPasswordTextField.text?.isEmpty, true , "new")
        XCTAssertEqual(sut.confirmPasswordTextField.text?.isEmpty, true , "confirmation")

    }
    
    func test_tappingOKInTooShortAlert_shouldNotClearOldPasswordField() throws {
        setUpEntriesNewPasswordTooShort()
        tap(sut.submitButton)
        try alertVerifier.executeAction(forButton: "OK")
        
        XCTAssertEqual(sut.oldPasswordTextField.text?.isEmpty, false)
    }
    
    func test_tappingOKInTooShortAlert_shouldFocusOnNewPasswordField() throws {
        setUpEntriesNewPasswordTooShort()
        tap(sut.submitButton)
        putViewInHierarchy(sut)
        try alertVerifier.executeAction(forButton: "OK")
        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
    }
    
    private func setUpMismatchedConfirmationEntry(){
        sut.oldPasswordTextField.text = "NONEMPTY"
        sut.newPasswordTextField.text = "123456"
        sut.confirmPasswordTextField.text = "qwerty"
    }
    
    func test_tappingSubmit_withConfirmationMismatch_shouldNotChangePassword(){
        setUpMismatchedConfirmationEntry()
        tap(sut.submitButton)
        passwordChanger.verifyChangeNeverCalled()
    }
    
    func test_tappingSubmit_withConfirmationMismatch_shouldShowMismatchAlert(){
        setUpMismatchedConfirmationEntry()
        tap(sut.submitButton)
        verifyAlertPresented(message: "The new password and the confirmation password don't match. Please try again.")
    }
    
    func test_tappingOKInConfirmationMismatch_shouldClearNewAndConfirmation() throws {
        setUpMismatchedConfirmationEntry()
        tap(sut.submitButton)
        try alertVerifier.executeAction(forButton: "OK")
        
        XCTAssertEqual(sut.newPasswordTextField.text?.isEmpty, true , "new")
        XCTAssertEqual(sut.confirmPasswordTextField.text?.isEmpty, true , "confirmation")

    }
    
    func test_tappingOKInConfirmationMismatch_shouldNotClearOldPasswordField() throws {
        setUpMismatchedConfirmationEntry()
        tap(sut.submitButton)
        try alertVerifier.executeAction(forButton: "OK")
        
        XCTAssertEqual(sut.oldPasswordTextField.text?.isEmpty, false)
    }
    
    func test_tappingOKInConfirmationMismatch_shouldFocusOnNewPasswordField() throws {
        setUpMismatchedConfirmationEntry()
        tap(sut.submitButton)
        putViewInHierarchy(sut)
        try alertVerifier.executeAction(forButton: "OK")
        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
    }
    
    func test_tappingSubmit_withValidFieldsFocusedOnOldPassword_resignFocus(){
        setUpValidPasswordEntries()
        putFocusOn(textField: sut.oldPasswordTextField)
        XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder, "precondition")
        tap(sut.submitButton)
        XCTAssertFalse(sut.oldPasswordTextField.isFirstResponder)
    }
    
    func test_tappingSubmit_withValidFieldsFocusedOnNewPassword_resignFocus(){
        setUpValidPasswordEntries()
        putFocusOn(textField: sut.newPasswordTextField)
        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder, "precondition")
        tap(sut.submitButton)
        XCTAssertFalse(sut.newPasswordTextField.isFirstResponder)
    }
    
    func test_tappingSubmit_withValidFieldsFocusedOnConfirmPassword_resignFocus(){
        setUpValidPasswordEntries()
        putFocusOn(textField: sut.confirmPasswordTextField)
        XCTAssertTrue(sut.confirmPasswordTextField.isFirstResponder, "precondition")
        tap(sut.submitButton)
        XCTAssertFalse(sut.confirmPasswordTextField.isFirstResponder)
    }
    
    func test_tappingSubmit_withValidFields_shouldDisableCancelBarButton(){
        setUpValidPasswordEntries()
        XCTAssertTrue(sut.cancelBarButton.isEnabled, "precondition")
        tap(sut.submitButton)
        XCTAssertFalse(sut.cancelBarButton.isEnabled)
    }
    
    func test_tappingSubmit_withValidFields_shouldShowBlurView(){
        setUpValidPasswordEntries()
        XCTAssertNil(sut.blurView.superview, "precondition")
        tap(sut.submitButton)
        XCTAssertNotNil(sut.blurView.superview)
    }
    
    func test_tappingSubmit_withValidFields_shouldShowActivityIndicator(){
        setUpValidPasswordEntries()
        XCTAssertNil(sut.activityIndicator.superview, "precondition")
        tap(sut.submitButton)
        XCTAssertNotNil(sut.activityIndicator.superview)
    }
    
    func test_tappingSubmit_withValidFields_shouldStartActivityAnimation(){
        setUpValidPasswordEntries()
        XCTAssertFalse(sut.activityIndicator.isAnimating, "precondition")
        tap(sut.submitButton)
        XCTAssertTrue(sut.activityIndicator.isAnimating)
    }
    
    func test_tappingSubmit_withValidFields_shouldClearBackgroundColorForBlur(){
        setUpValidPasswordEntries()
        XCTAssertNotEqual(sut.view.backgroundColor, .clear, "precondition")
        tap(sut.submitButton)
        XCTAssertEqual(sut.view.backgroundColor, .clear)
    }
    
    func test_tappingSubmit_withValidFields_shouldRequestChangePassword(){
        sut.securityToken = "TOKEN"
        sut.oldPasswordTextField.text = "OLD456"
        sut.newPasswordTextField.text = "NEW456"
        sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
        
        tap(sut.submitButton)
        
        passwordChanger.verifyChange(securityToken: "TOKEN", oldPassword: "OLD456", newPassword: "NEW456")
    }
    
    func test_changePasswordSuccess_shouldStopActivityIndicatorAnimation(){
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        XCTAssertTrue(sut.activityIndicator.isAnimating, "precondition")
        passwordChanger.changeCallSuccess()
        XCTAssertFalse(sut.activityIndicator.isAnimating)
    }
    
    func test_changePasswordSuccess_shouldHideActivityIndicator(){
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        XCTAssertNotNil(sut.activityIndicator.superview, "precondition")
        passwordChanger.changeCallSuccess()
        XCTAssertNil(sut.activityIndicator.superview)
    }
    
    func test_changePasswordFailure_shouldStopActivityIndicatorAnimation(){
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        XCTAssertTrue(sut.activityIndicator.isAnimating, "precondition")
        passwordChanger.changeCallFailure(message: "DUMMY")
        XCTAssertFalse(sut.activityIndicator.isAnimating)
    }
    
    func test_changePasswordfailure_shouldHideActivityIndicator(){
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        XCTAssertNotNil(sut.activityIndicator.superview, "precondition")
        passwordChanger.changeCallFailure(message: "DUMMY")
        XCTAssertNil(sut.activityIndicator.superview)
    }
    
    func test_changePasswordSuccess_shouldShowSuccessAlert(){
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        passwordChanger.changeCallSuccess()
        verifyAlertPresented(message: "Your password has been successfully changed.")
    }
    
    func test_tappingOkInSuccessAlert_shouldDismissModal() throws {
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        passwordChanger.changeCallSuccess()
        let dismissalertVerifier = DismissalVerifier()
        try alertVerifier.executeAction(forButton: "OK")
        dismissalertVerifier.verify(animated: true, dismissedViewController: sut)
        
    }
    
    func test_changePasswordFailure_shouldShowFailureAlertWithGivenMessage(){
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        passwordChanger.changeCallFailure(message: "MESSAGE")
        
        verifyAlertPresented(message: "MESSAGE")
    }
    
    private func showPasswordChangeFailureAlert(){
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        passwordChanger.changeCallFailure(message: "DUMMY")
    }
    
    func test_tappingOKInFailureAlert_shouldClearAllFieldsToStartOver() throws {
        showPasswordChangeFailureAlert()
        try alertVerifier.executeAction(forButton: "OK")
        XCTAssertEqual(sut.oldPasswordTextField.text?.isEmpty, true, "old")
        XCTAssertEqual(sut.newPasswordTextField.text?.isEmpty, true, "new")
        XCTAssertEqual(sut.confirmPasswordTextField.text?.isEmpty, true, "confirmation")
    }
    
    func test_tappingOKInFailureAlert_shouldFocusOnOldPassword() throws {
        showPasswordChangeFailureAlert()
        putViewInHierarchy(sut)
        try alertVerifier.executeAction(forButton: "OK")
        XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder)
    }
    
    func test_tappingOKInFailureAlert_shouldSetBackgroundBackToWhite() throws {
        showPasswordChangeFailureAlert()
        XCTAssertNotEqual(sut.view.backgroundColor, .white, "precondition")
        try alertVerifier.executeAction(forButton: "OK")
        XCTAssertEqual(sut.view.backgroundColor, .white)
    }
    
    func test_tappingOKInFailureAlert_shouldHideBlur() throws {
        showPasswordChangeFailureAlert()
        XCTAssertNotNil(sut.blurView.superview)
        try alertVerifier.executeAction(forButton: "OK")
        XCTAssertNil(sut.blurView.superview)
    }
    
    func test_tappingOKFailureAlert_shouldEnableCancelButton() throws {
        showPasswordChangeFailureAlert()
        XCTAssertFalse(sut.cancelBarButton.isEnabled, "precondition")
        try alertVerifier.executeAction(forButton: "OK")
        XCTAssertTrue(sut.cancelBarButton.isEnabled)
    }
    
    func test_tappingOKFailureAlert_shouldNotDismissModal() throws {
        showPasswordChangeFailureAlert()
        let dismissalertVerifier = DismissalVerifier()
        try alertVerifier.executeAction(forButton: "OK")
        XCTAssertEqual(dismissalertVerifier.dismissedCount, 0)
    }
    
    func test_textFieldDelegates_shouldBeConnected(){
        XCTAssertNotNil(sut.oldPasswordTextField.delegate, "oldPasswordTextField")
        XCTAssertNotNil(sut.newPasswordTextField.delegate, "newPasswordTextField")
        XCTAssertNotNil(sut.confirmPasswordTextField.delegate, "confirmPasswordTextField")
    }
    
    func test_hittingReturnFromOldPassword_shouldPutFocusOnNewPassword(){
        putViewInHierarchy(sut)
        shouldReturn(in: sut.oldPasswordTextField)
        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
    }
    
    func test_hittingReturnFromNewPassword_shouldPutFocuOnConfirmPassword(){
        putViewInHierarchy(sut)
        shouldReturn(in: sut.newPasswordTextField)
        XCTAssertTrue(sut.confirmPasswordTextField.isFirstResponder)
    }
    
    func test_hittingReturnFromConfirmPassword_shouldRequestPasswordChange(){
        sut.securityToken = "TOKEN"
        sut.oldPasswordTextField.text = "OLD456"
        sut.newPasswordTextField.text = "NEW456"
        sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
        
        shouldReturn(in: sut.confirmPasswordTextField)
        
        passwordChanger.verifyChange(securityToken: "TOKEN", oldPassword: "OLD456", newPassword: "NEW456")
    }
    
    func test_hittingReturnFromOldPassword_shouldNotRequestPasswordChange(){
        setUpValidPasswordEntries()
        
        shouldReturn(in: sut.oldPasswordTextField)
        passwordChanger.verifyChangeNeverCalled()
    }
    
    func test_hittingReturnFromNewPassword_shouldNotRequestPasswordChange(){
        setUpValidPasswordEntries()
        shouldReturn(in: sut.newPasswordTextField)
        passwordChanger.verifyChangeNeverCalled()
    }
}

