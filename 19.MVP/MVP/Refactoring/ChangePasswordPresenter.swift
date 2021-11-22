//
//  ChangePasswordPresenter.swift
//  MVP
//
//  Created by RATAMATE on 22/11/21.
//

import Foundation

class ChangePasswordPresenter {
    private unowned var view: ChangePasswordViewCommands!
    private var labels: ChangePasswordLabels
    private var securityToken: String
    private var passwordChanger: PasswordChanging
    
    init(view: ChangePasswordViewCommands, labels: ChangePasswordLabels,securityToken: String, passwordChanger: PasswordChanging) {
        self.view = view
        self.labels = labels
        self.securityToken = securityToken
        self.passwordChanger = passwordChanger
    }
    
    func cancel(){
        view.updateInputFocus(.noKeyboard)
        view.dismissModal()
    }
    
    func changePassword(passwordInputs: PasswordInputs){
        guard validateInputs(passwordInputs: passwordInputs) else { return }
        setUpWaitingAppearance()
        attemptToChangePassword(passwordInputs: passwordInputs)
    }
    
    
    private func setUpWaitingAppearance() {
        view.updateInputFocus(.noKeyboard)
        view.setCancelButtonEnable(false)
        view.showBlurView()
        view.showActivityIndicator()
    }
    
    
    private func validateInputs(passwordInputs: PasswordInputs) -> Bool {
        if passwordInputs.isOldPasswordIsEmpty {
            view.updateInputFocus(.oldPassword)
            return false
        }
        
        if passwordInputs.isNewPasswordIsEmpty {
            view.showAlert(message: labels.enterNewPasswordTooShortMessage) { [weak self] in
                self?.view.updateInputFocus(.newPassword)
            }
            return false
        }
        
        if passwordInputs.isNewPasswordTooShort {
            view.showAlert(message: labels.newPasswordTooShortMessage) { [weak self] in
                self?.resetNewPasswords()
            }
            return false
        }
        
        if passwordInputs.isConfirmPasswordMismatched {
            view.showAlert(message: labels.confirmationPasswordDoesNotMatchMessage) {[weak self] in
                self?.resetNewPasswords()
            }
            return false
        }
        return true
    }
    
    private func attemptToChangePassword(passwordInputs: PasswordInputs) {
        passwordChanger.change(securityToken: securityToken, oldPassword: passwordInputs.oldPassword, newPassword: passwordInputs.newPassword, onSuccess: { [weak self] in
            self?.handleSuccess()
        }, onFailure: { [weak self] message in
            self?.handleFailure(message: message)
        })
    }
    
    
    private func handleSuccess(){
        view.hideActivityIndicator()
        view.showAlert(message: labels.successMessage) { [weak self] in
            self?.view.dismissModal()
        }
    }
    
    private func handleFailure(message: String){
        view.hideActivityIndicator()
        view.showAlert(message: message) { [weak self] in
            self?.startOver()
            
        }
    }
    
    private func startOver(){
        view.clearAllPasswordFields()
        view.updateInputFocus(.oldPassword)
        view.hideBlurView()
        view.setCancelButtonEnable(true)
    }
    
    private func resetNewPasswords(){
        view.clearNewPasswordFields()
        view.updateInputFocus(.newPassword)
    }
    
}
