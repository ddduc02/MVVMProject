//
//  ProfileViewModel.swift
//  MVVMProject
//
//  Created by ducdo on 22/01/2024.
//

import Foundation
import FirebaseAuth

class ProfileViewModel {
    var user : Binding<User?>
    var post : Binding<[Post]>
    var userId : String
    init() {
        self.user = Binding(value: nil)
        self.post = Binding(value: [])
        self.userId = Auth.auth().currentUser?.uid ?? ""
        print("check userId \(self.userId)")
        getUser()
    }
    
    func getUser() {
        FirebaseService.instance.getUser(userId: self.userId) { [weak self] user in
            guard let user = user else {
                return
            }
            self?.user.value = user
        }
    }
    
    func userChanged(newValue : User) {
        user.value = newValue
    }
    
    func postChanged(newValue : [Post]) {
        post.value = newValue
    }
}
