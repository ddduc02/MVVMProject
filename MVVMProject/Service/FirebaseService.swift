//
//  FirebaseService.swift
//  MVVMProject
//
//  Created by ducdo on 22/01/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class FirebaseService {
    static let instance = FirebaseService()
    let db = Firestore.firestore()
    
    private init() {
    }
    
    func getUser(userId : String, completion: @escaping (User?) -> Void) {
        print("run getUser with id \(userId)")
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            if let error = error {
                print("Lỗi khi truy vấn collection users: \(error)")
                return
            }
            
            if let data = snapshot?.data() { // user dưới dạng json
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let userModel =  try JSONDecoder().decode(User.self, from: jsonData)
                    print("check userModel \(userModel)")
                    completion(userModel)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil)
                }
                
                completion(nil)
            }
        }
    }
    
    func getUserWithPost() {
        db.collection("users").getDocuments { (snapshot, error) in
            
        }
    }
}
