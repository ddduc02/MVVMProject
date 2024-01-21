//
//  MainViewModel.swift
//  MVVMProject
//
//  Created by ducdo on 21/01/2024.
//

import Foundation
import FirebaseAuth
class MainViewModel {
    var currentUserId : Binding<String>
    init() {
        currentUserId = Binding(value: "")
        Auth.auth().addStateDidChangeListener({ _, user in
            // thực hiện việc set uid trên luồng chính, và khi có sự thay đổi về currentUserId thì UI sẽ render lại
            DispatchQueue.main.async {
                self.currentUserId.value = user?.uid ?? ""
            }
        })
    }
    
    func isSignIn() -> Bool {
        return Auth.auth().currentUser?.uid != nil
    }
    func currentUserIdChanged(newValue : String) {
        currentUserId.value = newValue
    }
    
}
