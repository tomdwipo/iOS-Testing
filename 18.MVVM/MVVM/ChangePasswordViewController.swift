//
//  ChangePasswordViewController.swift
//  Refactoring
//
//  Created by RATAMATE on 15/11/21.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private(set) var cancelBarButton: UIBarButtonItem!
    @IBOutlet private(set) var oldPasswordTextField: UITextField!
    @IBOutlet private(set) var newPasswordTextField: UITextField!
    @IBOutlet private(set) var confirmPasswordTextField: UITextField!
    @IBOutlet private(set) var submitButton: UIButton!
    
    @IBOutlet private(set) var navigationBar: UINavigationBar!
    
    var viewModel: ChangePasswordViewModel! {
        didSet {
            guard isViewLoaded else { return }
            if oldValue.isCancelButtonIsEnable != viewModel.isCancelButtonIsEnable {
                cancelBarButton.isEnabled = viewModel.isCancelButtonIsEnable
            }
        }
    }
    
    lazy var passwordChanger: PasswordChanging = PasswordChanger()
    var securityToken = ""
    
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor(red: 55/255.0, green: 147/255.0, blue: 251/255.0, alpha: 1.0).cgColor
        submitButton.layer.cornerRadius = 8
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        setLabels()
    }
    
    @IBAction private func cancel(){
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    
    @IBAction private func changePassword(){
        guard validateInputs() else { return }
        
        setUpWaitingAppearance()
        attemptToChangePassword()
        
    }
    
    
    private func validateInputs() -> Bool {
        if oldPasswordTextField.text?.isEmpty ?? true {
            oldPasswordTextField.becomeFirstResponder()
            return false
        }
        
        if newPasswordTextField.text?.isEmpty ?? true {
            showAlert(message: viewModel.enterNewPasswordTooShortMessage) { [weak self] _ in self?.newPasswordTextField.becomeFirstResponder()
            }
            return false
        }
        
        if newPasswordTextField.text?.count ?? 0 < 6 {
            showAlert(message: viewModel.newPasswordTooShortMessage) { [weak self] _ in
                self?.resetNewPasswords()
            }
            return false
        }
        
        if newPasswordTextField.text != confirmPasswordTextField.text {
            showAlert(message: viewModel.confirmationPasswordDoesNotMatchMessage) {[weak self] _ in
                self?.resetNewPasswords()
            }
            return false
        }
        return true
    }
    
    private func resetNewPasswords(){
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
        newPasswordTextField.becomeFirstResponder()
    }

    
    private func setUpWaitingAppearance() {
        view.endEditing(true)
        viewModel.isCancelButtonIsEnable = false
        view.backgroundColor = .clear
        view.addSubview(blurView)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }
    
    private func attemptToChangePassword() {
        passwordChanger.change(securityToken: securityToken, oldPassword: oldPasswordTextField.text ?? "", newPassword: newPasswordTextField.text ?? "", onSuccess: { [weak self] in
            self?.handleSuccess()
        }, onFailure: { [weak self] message in
            self?.handleFailure(message: message)
        })
    }
    
    private func handleSuccess(){
        hideSpinner()
        showAlert(message: viewModel.successMessage, okAction: { [weak self] _ in
            self?.dismiss(animated: true)
        })
    }
    
    private func handleFailure(message: String){
        hideSpinner()
        showAlert(message: message, okAction: { [weak self] _ in
            self?.startOver()
            
        })
    }
    
    private func showAlert(message: String, okAction: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: viewModel.okButtonLabel, style: UIAlertAction.Style.default, handler: okAction)
        alertController.addAction(okButton)
        alertController.preferredAction = okButton
        self.present(alertController, animated: true)
    }
    
    private func hideSpinner(){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    private func startOver(){
        oldPasswordTextField.text = ""
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
        
        oldPasswordTextField.becomeFirstResponder()
        view.backgroundColor = .white
        
        blurView.removeFromSuperview()
        
        viewModel.isCancelButtonIsEnable = true
        
    }
    
    private func setLabels(){
        navigationBar.topItem?.title = viewModel.title
        oldPasswordTextField.placeholder = viewModel.oldPasswordPlaceholder
        newPasswordTextField.placeholder = viewModel.newPasswordPlaceholder
        confirmPasswordTextField.placeholder = viewModel.confirmPasswordPlaceholder
        submitButton.setTitle(viewModel.submitButtonLabel, for: UIControl.State.normal)
    }
}


extension ChangePasswordViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === oldPasswordTextField {
            newPasswordTextField.becomeFirstResponder()
        }else if (textField === newPasswordTextField) {
            confirmPasswordTextField.becomeFirstResponder()
        }else if (textField === confirmPasswordTextField) {
            changePassword()
        }
        return true
    }
    
}
