//
//  User.swift
//  MVVMProject
//
//  Created by ducdo on 15/01/2024.
//

import Foundation

struct User : Decodable {
    let id : String
    var name : String
    var email : String
    var phone : String
    var password : String
    var imageUrl : String? = nil
}

extension User {
    func asDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "id": id,
            "name": name,
            "email": email,
            "phone": phone,
            "password": password
        ]

        if let imageUrl = imageUrl {
            dictionary["imageUrl"] = imageUrl
        }

        return dictionary
    }
}
