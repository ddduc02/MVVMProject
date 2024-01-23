//
//  EditProfileViewModel.swift
//  MVVMProject
//
//  Created by ducdo on 22/01/2024.
//

import Foundation
import UIKit

class EditProfileViewModel {
    var user: Binding<User>
    var uesrImage: UIImage?
    init(user : User) {
        self.user = Binding(value: user)
    }
    
    func updateInfor(user: User, completion: @escaping (Bool) -> Void) {
        FirebaseService.instance.editUser(user: user, userImage: self.uesrImage!) { success in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
