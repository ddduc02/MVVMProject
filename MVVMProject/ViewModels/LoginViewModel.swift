//
//  LoginViewModel.swift
//  MVVMProject
//
//  Created by ducdo on 16/01/2024.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    var email : Binding<String>
    var password : Binding<String>
    var error : Binding<String>
    
    init() {
        self.email = Binding<String>(value: "")
        self.password = Binding<String>(value: "")
        self.error = Binding<String>(value: "")
    }
    
    func login(result : @escaping ((Bool) -> Void)) {
        guard validate() else {
            result(false)
            return
        }
        
        do {
            try Auth.auth().signIn(withEmail: email.value, password: password.value)
        } catch {
            
            result(false)
        }
        result(true)
    }
    
    func validate() -> Bool {
        guard !email.value.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.value.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            emailChanged("Please enter some text")
            return false
        }
        guard email.value.contains("@") && email.value.contains(".") else {
            emailChanged("Please enter valid message")
            return false
        }
        return true
    }
    
    func emailChanged(_ newValue : String) {
        email.value = newValue
    }
    
    func passwordChanged(_ newValue : String) {
        password.value = newValue
    }
    
    func errorChanged(_ newValue : String) {
        error.value = newValue
    }
}


