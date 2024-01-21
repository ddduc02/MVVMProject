//
//  SignupViewModel.swift
//  MVVMProject
//
//  Created by ducdo on 18/01/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SignupViewModel {
    var fullName: Binding<String>
    var email: Binding<String>
    var phoneNumber: Binding<String>
    var password: Binding<String>
    var errorLabel: Binding<String>
    
    init() {
        self.fullName = Binding<String>(value: "")
        self.email = Binding<String>(value: "")
        self.phoneNumber = Binding<String>(value: "")
        self.password = Binding<String>(value: "")
        self.errorLabel = Binding<String>(value: "")
    }
    
    func signUp(result : @escaping ((Bool) -> Void)) {
        guard validate() else {
            result(false)
            return
        }
        Auth.auth().createUser(withEmail: email.value, password: password.value) { result, error in
            guard let userId = result?.user.uid else {
                return
            }
            self.insertRecord(userId: userId)
        }
        result(true)
    }
    
    func insertRecord(userId : String) {
        let user = User(id: userId, name: fullName.value, email: email.value, phone: phoneNumber.value, password: password.value)
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .setData(user.asDictionary())
    }
    
    func validate() -> Bool {
        guard !fullName.value.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.value.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.value.trimmingCharacters(in: .whitespaces).isEmpty,
              !phoneNumber.value.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorChanged("Please enter some text")
            return false
        }
        
        guard email.value.contains("@") && email.value.contains(".") else {
            errorChanged("Invalid email")
            return false
        }
        
        guard password.value.count >= 8 else {
            errorChanged("Password must be greater 8 characters")
            return false
        }
        
        return true
        
    }
    
    func fullNameChanged(_ newValue : String) {
        fullName.value = newValue
    }
    func emailChanged(_ newValue : String) {
        email.value = newValue
    }
    func phoneChanged(_ newValue : String) {
        phoneNumber.value = newValue
    }
    func passwordChanged(_ newValue : String) {
        password.value = newValue
    }
    
    func errorChanged(_ newValue : String) {
        errorLabel.value = newValue
    }
    
    
}
