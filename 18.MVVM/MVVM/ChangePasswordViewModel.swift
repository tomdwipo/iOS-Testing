//
//  ChangePasswordViewModel.swift
//  MVVM
//
//  Created by RATAMATE on 21/11/21.
//

import Foundation

struct ChangePasswordViewModel {
    let okButtonLabel: String
    let enterNewPasswordTooShortMessage: String
    let newPasswordTooShortMessage: String
    let confirmationPasswordDoesNotMatchMessage: String
    let successMessage: String
    let title: String
    let oldPasswordPlaceholder: String
    let newPasswordPlaceholder: String
    let confirmPasswordPlaceholder: String
    let submitButtonLabel: String
    
    var isCancelButtonIsEnable = true
    
    var inputFocus: InputFocus = .noKeyboard
    
    enum InputFocus {
        case noKeyboard
        case oldPassword
        case newPassword
        case confirmPassword
    }
    
    var isBlurViewShowing = false
    var isActivityIndicatorShowing = false
    
    var oldPassword = ""
    var newPassword = ""
    var confirmPassword = ""
    
    var isOldPasswordIsEmpty: Bool { oldPassword.isEmpty }
    var isNewPasswordIsEmpty: Bool { newPassword.isEmpty }
    var isNewPasswordTooShort: Bool { newPassword.count < 6 }
    var isConfirmPasswordMismatched: Bool { newPassword != confirmPassword }
}


