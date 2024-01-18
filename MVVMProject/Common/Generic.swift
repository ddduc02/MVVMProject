//
//  Generic.swift
//  MVVMProject
//
//  Created by ducdo on 17/01/2024.
//

import Foundation

class Binding<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        self.listener?(value)
    }
}
