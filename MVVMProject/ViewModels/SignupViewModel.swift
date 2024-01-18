//
//  SignupViewModel.swift
//  MVVMProject
//
//  Created by ducdo on 18/01/2024.
//

import Foundation

class SignupViewModel {
    var fullNameField: Binding<String>
    var emailField: Binding<String>
    var phoneNumberField: Binding<String>
    var passwordField: Binding<String>
    var errorLabel: Binding<String>
    
    init() {
        self.fullNameField = Binding<String>(value: "")
        self.emailField = Binding<String>(value: "")
        self.phoneNumberField = Binding<String>(value: "")
        self.passwordField = Binding<String>(value: "")
        self.errorLabel = Binding<String>(value: "")
    }
    
    func signUp(result : @escaping ((Bool) -> Void)) {
        if checkValid() {
            let user = User(name: fullNameField.value, email: emailField.value, phone: phoneNumberField.value, password: passwordField.value)
            Database.instance.users.append(user)
            result(true)
        } else {
            result(false)
        }
    }
    
    func checkValid() -> Bool {
        if fullNameField.value.isEmpty {
            self.errorChanged("Fullname can not be empty!")
            return false
        } else if !emailField.value.contains("@") || emailField.value.isEmpty {
            self.errorChanged("Email is invalid!")
            return false
        } else if phoneNumberField.value.isEmpty {
            self.errorChanged("Phone number can not be empty")
            return false
        } else if passwordField.value.count < 6 {
            self.errorChanged("Password length must be greater than 6 characters!")
            return false
        }
        return true
    }
    
    func fullNameChanged(_ newValue : String) {
        fullNameField.value = newValue
    }
    func emailChanged(_ newValue : String) {
        emailField.value = newValue
    }
    func phoneChanged(_ newValue : String) {
        phoneNumberField.value = newValue
    }
    func passwordChanged(_ newValue : String) {
        passwordField.value = newValue
    }
    
    func errorChanged(_ newValue : String) {
        errorLabel.value = newValue
    }
    
    
}
