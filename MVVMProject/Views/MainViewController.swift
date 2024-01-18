//
//  MainViewController.swift
//  MVVMProject
//
//  Created by ducdo on 17/01/2024.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabbarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor, UIColor.white.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        tabbarView.layer.cornerRadius = tabbarView.frame.height / 2
        tabbarView.layer.masksToBounds = true
        let home = HomeViewController()
        contentView.addSubview(home.view)
        addChild(home)
    }
}
