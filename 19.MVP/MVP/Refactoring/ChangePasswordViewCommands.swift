//
//  ChangePasswordViewCommands.swift
//  MVP
//
//  Created by RATAMATE on 22/11/21.
//

import Foundation

protocol ChangePasswordViewCommands: AnyObject {
    func hideActivityIndicator()
    func showActivityIndicator()
    func dismissModal()
    func showAlert(message: String, action: @escaping () -> Void)
    
    func hideBlurView()
    func showBlurView()
    
    func setCancelButtonEnable(_ enabled: Bool)
    
    func updateInputFocus(_ inputFocus: InputFocus)
    
    func clearAllPasswordFields()
    func clearNewPasswordFields()
}


enum InputFocus {
    case noKeyboard
    case oldPassword
    case newPassword
    case confirmPassword
}
