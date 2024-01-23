//
//  MainViewController.swift
//  MVVMProject
//
//  Created by ducdo on 17/01/2024.
//

import UIKit
import FirebaseAuth

class MainViewController: UITabBarController {
    private var logoApp : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoApp()
        setupTabbar()
        setupHomeNavigationBar()
        
        self.delegate = self
        self.navigationController?.navigationBar.tintColor = .black
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
    
    func setupLogoApp() {
        logoApp = UILabel(frame: CGRect(x: 8, y: 0, width: 50, height: 40))
        logoApp.text = "My Social App"
        logoApp.font = UIFont(name: "Bradley Hand", size: 24)
    }
    
    func setupTabbar() {
        let home = HomeViewController()
        let explore = ExploreViewController()
        let newPost = NewPostViewController()
        let message = MessageViewController()
        let profile = ProfileViewController()
        
        home.tabBarItem.image = UIImage(systemName: "house")
        home.tabBarItem.title = "Home"
        explore.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        explore.tabBarItem.title = "Search"
        newPost.tabBarItem.image = UIImage(systemName: "plus.app.fill")
        message.tabBarItem.image = UIImage(systemName: "message")
        message.tabBarItem.title = "Inbox"
        profile.tabBarItem.image = UIImage(systemName: "person")
        profile.tabBarItem.title = "Profile"
        
        self.setViewControllers([home,explore,newPost,message,profile], animated: true)
    }
    
    func setupHomeNavigationBar() {
        self.navigationItem.title = nil
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoApp)
    }
    
    func setupExploreNavigationBar() {
        self.navigationItem.title = nil
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func setupMessageNavigation() {
        self.navigationItem.title = "Message"
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func setupProfileNavigation() {
        self.navigationItem.title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(self.logout))
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func navigateToNewPostScreen() {
        let newPost = NewPostViewController()
        self.navigationController?.pushViewController(newPost, animated: true)
    }
    
    
    @objc func logout() {
        print("check")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let login = LoginViewController()
            navigationController?.setViewControllers([login], animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension MainViewController : UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if selectedIndex == tabBarController.selectedIndex {
            switch selectedIndex {
            case 0: setupHomeNavigationBar()
            case 1: setupExploreNavigationBar()
            case 2:
                navigateToNewPostScreen()
                tabBarController.selectedIndex = 0
            case 3: setupMessageNavigation()
            default:
                setupProfileNavigation()
            }
        }
    }
}
