//
//  Database.swift
//  MVVMProject
//
//  Created by ducdo on 15/01/2024.
//

import Foundation

class Database {
    static let instance = Database()
    
    private init() {}
    
    var users : [User] = [User(name: "ducdo", email: "duc@gmail.com", phone: "12345678", password: "abc123")]
}
