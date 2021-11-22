//
//  PasswordInputs.swift
//  MVP
//
//  Created by RATAMATE on 22/11/21.
//

import Foundation

struct PasswordInputs {
    let oldPassword: String
    let newPassword: String
    let confirmPassword: String
    
    var isOldPasswordIsEmpty: Bool { oldPassword.isEmpty }
    var isNewPasswordIsEmpty: Bool { newPassword.isEmpty }
    var isNewPasswordTooShort: Bool { newPassword.count < 6 }
    var isConfirmPasswordMismatched: Bool { newPassword != confirmPassword }
}
