//
//  LoginViewController.swift
//  MVVMProject
//
//  Created by ducdo on 15/01/2024.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.error.bind(listener: { [weak self] value in
            self?.errorLabel.text = value
        })
    }
    
    @IBAction func onNextTap(_ sender: UIButton) {
        guard let email = emailField.text else {
            return
        }
        
        guard let password = passwordField.text else {
            return
        }
        
        loginViewModel.email.value = email
        loginViewModel.password.value = password
        loginViewModel.login {[weak self] result in
            if result {
                let main = MainViewController()
                self?.navigationController?.setViewControllers([main], animated: true)
            }
        }
    }
    
    @IBAction func onRegisterTap(_ sender: UIButton) {
        let signup = SignupViewController()
        self.navigationController?.pushViewController(signup, animated: true)
    }
}
