//
//  MyExtensions.swift
//  MVVMProject
//
//  Created by ducdo on 22/01/2024.
//

import Foundation
import UIKit

extension UIView {
    func round() {
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
    }
}
