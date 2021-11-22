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
        
   
    lazy var passwordChanger: PasswordChanging = PasswordChanger()
    var securityToken = ""
    
    var viewModel: ChangePasswordViewModel!

    private lazy var presenter = ChangePasswordPresenter(view: self, viewModel: viewModel, securityToken: securityToken, passwordChanger: passwordChanger)
    
   
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
        updateInputFocus(.noKeyboard)
        dismiss(animated: true)
    }
    
    
    @IBAction private func changePassword(){
        updateViewModelToTextFields()
        guard presenter.validateInputs() else { return }
        presenter.setUpWaitingAppearance()
        presenter.attemptToChangePassword()
        
    }
 
}

extension ChangePasswordViewController {
 
    
    private func setLabels(){
        navigationBar.topItem?.title = viewModel.title
        oldPasswordTextField.placeholder = viewModel.oldPasswordPlaceholder
        newPasswordTextField.placeholder = viewModel.newPasswordPlaceholder
        confirmPasswordTextField.placeholder = viewModel.confirmPasswordPlaceholder
        submitButton.setTitle(viewModel.submitButtonLabel, for: UIControl.State.normal)
    }
    
    private func updateViewModelToTextFields(){
        viewModel.oldPassword = oldPasswordTextField.text ?? ""
        viewModel.newPassword = newPasswordTextField.text ?? ""
        viewModel.confirmPassword = confirmPasswordTextField.text ?? ""
    }
}


extension ChangePasswordViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === oldPasswordTextField {
            updateInputFocus(.newPassword)
        }else if (textField === newPasswordTextField) {
            updateInputFocus(.confirmPassword)
        }else if (textField === confirmPasswordTextField) {
            changePassword()
        }
        return true
    }
    
}


extension ChangePasswordViewController: ChangePasswordViewCommands {
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func showActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissModal() {
       self.dismiss(animated: true)
   }
    
    func showAlert(message: String, action: @escaping () -> Void) {
        let wrappedAction: (UIAlertAction) -> Void = { _ in action() }
        showAlert(message: message) { wrappedAction($0) }
    }
    
    func hideBlurView(){
        view.backgroundColor = .white
        blurView.removeFromSuperview()
    }
    
    func showBlurView(){
        view.backgroundColor = .clear
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    func setCancelButtonEnable(_ enabled: Bool) {
        cancelBarButton.isEnabled = enabled
    }
    
    func updateInputFocus(_ inputFocus: InputFocus) {
        switch inputFocus {
        case .noKeyboard:
            view.endEditing(true)
        case .oldPassword:
            oldPasswordTextField.becomeFirstResponder()
        case .newPassword:
            newPasswordTextField.becomeFirstResponder()
        case .confirmPassword:
            confirmPasswordTextField.becomeFirstResponder()
        }
    }
    
    func clearAllPasswordFields() {
        oldPasswordTextField.text = ""
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
   
    func clearNewPasswordFields() {
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
}

extension ChangePasswordViewController {
    private func showAlert(message: String, okAction: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: viewModel.okButtonLabel, style: UIAlertAction.Style.default, handler: okAction)
        alertController.addAction(okButton)
        alertController.preferredAction = okButton
        self.present(alertController, animated: true)
    }
    
}
