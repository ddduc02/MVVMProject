//
//  ProfileViewController.swift
//  MVVMProject
//
//  Created by ducdo on 21/01/2024.
//

import UIKit
import FirebaseAuth
class ProfileViewController: UIViewController {
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var userName: UILabel!
    
    var profileViewModel : ProfileViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileViewModel = ProfileViewModel()
        profileViewModel.user.bind { user in
            self.userName.text = user?.name
        }
        profileViewModel.post.bind { posts in
            
        }
        avatarView.round()
    }
}
