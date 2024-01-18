//
//  RegisterViewController.swift
//  MVVMProject
//
//  Created by ducdo on 15/01/2024.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var signupViewModel = SignupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupViewModel.errorLabel.bind { [weak self] newValue in
            self?.errorLabel.text = newValue
        }
    }
    
    @IBAction func onTapNext(_ sender: UIButton) {
        signupViewModel.fullNameField.value = fullNameField.text ?? ""
        signupViewModel.emailField.value = emailField.text ?? ""
        signupViewModel.phoneNumberField.value = phoneNumberField.text ?? ""
        signupViewModel.passwordField.value = passwordField.text ?? ""
        signupViewModel.signUp { [weak self] success in
            if success {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
