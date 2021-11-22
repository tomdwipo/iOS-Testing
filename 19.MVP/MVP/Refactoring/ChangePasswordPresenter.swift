//
//  ChangePasswordPresenter.swift
//  MVP
//
//  Created by RATAMATE on 22/11/21.
//

import Foundation

class ChangePasswordPresenter {
    private unowned var view: ChangePasswordViewCommands!
    private var viewModel: ChangePasswordViewModel
    private var securityToken: String
    private var passwordChanger: PasswordChanging
    
    init(view: ChangePasswordViewCommands, viewModel: ChangePasswordViewModel,securityToken: String, passwordChanger: PasswordChanging) {
        self.view = view
        self.viewModel = viewModel
        self.securityToken = securityToken
        self.passwordChanger = passwordChanger
    }
 
    private func startOver(){
        view.clearAllPasswordFields()
        view.updateInputFocus(.oldPassword)
        view.hideBlurView()
        view.setCancelButtonEnable(true)
    }
    
    func setUpWaitingAppearance() {
        view.updateInputFocus(.noKeyboard)
        view.setCancelButtonEnable(false)
        view.showBlurView()
        view.showActivityIndicator()
    }
    
    
    func validateInputs() -> Bool {
        if viewModel.isOldPasswordIsEmpty {
            view.updateInputFocus(.oldPassword)
            return false
        }
        
        if viewModel.isNewPasswordIsEmpty {
            view.showAlert(message: viewModel.enterNewPasswordTooShortMessage) { [weak self] in
                self?.view.updateInputFocus(.newPassword)
            }
            return false
        }
        
        if viewModel.isNewPasswordTooShort {
            view.showAlert(message: viewModel.newPasswordTooShortMessage) { [weak self] in
                self?.resetNewPasswords()
            }
            return false
        }
        
        if viewModel.isConfirmPasswordMismatched {
            view.showAlert(message: viewModel.confirmationPasswordDoesNotMatchMessage) {[weak self] in
                self?.resetNewPasswords()
            }
            return false
        }
        return true
    }
    
    func attemptToChangePassword() {
        passwordChanger.change(securityToken: securityToken, oldPassword: viewModel.oldPassword, newPassword: viewModel.newPassword, onSuccess: { [weak self] in
            self?.handleSuccess()
        }, onFailure: { [weak self] message in
            self?.handleFailure(message: message)
        })
    }
    
    
     private func handleSuccess(){
         view.hideActivityIndicator()
         view.showAlert(message: viewModel.successMessage) { [weak self] in
             self?.view.dismissModal()
        }
    }
    
    private func handleFailure(message: String){
        view.hideActivityIndicator()
        view.showAlert(message: message) { [weak self] in
            self?.startOver()
            
        }
    }
    
    private func resetNewPasswords(){
        view.clearNewPasswordFields()
        view.updateInputFocus(.newPassword)
    }
    
}
