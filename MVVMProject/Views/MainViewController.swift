//
//  MainViewController.swift
//  MVVMProject
//
//  Created by ducdo on 17/01/2024.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
    
    func setupTabbar() {
        let home = HomeViewController()
        let profile = ProfileViewController()
        
        home.tabBarItem.image = UIImage(systemName: "house")
        profile.tabBarItem.image = UIImage(systemName: "person")
        
        self.setViewControllers([home,profile], animated: true)
    }
}
