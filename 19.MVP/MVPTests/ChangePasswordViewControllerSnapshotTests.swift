//
//  ChangePasswordViewControllerSnapshotTests.swift
//  RefactoringTests
//
//  Created by RATAMATE on 20/11/21.
//

import XCTest
import FBSnapshotTestCase
@testable import MVP

class ChangePasswordViewControllerSnapshotTests: FBSnapshotTestCase {
    private var sut: ChangePasswordViewController!
    override func setUp() {
        super.setUp()
        recordMode = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: ChangePasswordViewController.self)) as? ChangePasswordViewController
        sut.viewModel = ChangePasswordViewModel(okButtonLabel: "OK", enterNewPasswordTooShortMessage: "Please enter a New Password.", newPasswordTooShortMessage: "The new password should have at least 6 characters.", confirmationPasswordDoesNotMatchMessage: "The new password and the confirmation password don't match. Please try again.", successMessage: "Your password has been successfully changed.", title: "Change Password", oldPasswordPlaceholder: "Current Password", newPasswordPlaceholder: "New Password", confirmPasswordPlaceholder: "Confirm New Password", submitButtonLabel: "Submit")
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func setUpValidPasswordEntries(){
        sut.oldPasswordTextField.text = "NONEMPTY"
        sut.newPasswordTextField.text = "123456"
        sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
    }
    
    private func verifySnapshot(file: StaticString = #file, line: UInt = #line){
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.addSubview(sut.view)
        FBSnapshotVerifyViewController(sut, file: file, line: line )

    }
    
    func test_blur(){
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        verifySnapshot()
    }

}
