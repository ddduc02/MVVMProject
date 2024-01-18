//
//  LoginViewModel.swift
//  MVVMProject
//
//  Created by ducdo on 16/01/2024.
//

import Foundation

class LoginViewModel {
//    var email : String = ""
//    var password : String = ""
//    var errorDidChange : (() -> ()) = {}
//    var error : String = "" {
//        didSet {
//            self.errorDidChange()
//        }
//    }
    
    var email : Binding<String>
    var password : Binding<String>
    var error : Binding<String>
   
    init() {
        self.email = Binding<String>(value: "")
        self.password = Binding<String>(value: "")
        self.error = Binding<String>(value: "")
    }
    
    func login(result : @escaping ((Bool) -> Void)) {
        for user in Database.instance.users {
            if self.email.value == user.email && self.password.value == user.password {
                result(true)
                errorChanged("")
            } else {
                errorChanged("Email or password is not correct!")
                print(error)
            }
        }
        result(false)
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


