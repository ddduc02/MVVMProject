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
    let storageRef = Storage.storage().reference()
    
    private init() {
    }
    
    func getUser(userId : String, completion: @escaping (User?, UIImage?) -> Void) {
        
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            if let error = error {
                print("Lỗi khi truy vấn collection users: \(error)")
                return
            }
            
            if let data = snapshot?.data() { // user dưới dạng json
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let userModel =  try JSONDecoder().decode(User.self, from: jsonData)
                    if let url = userModel.imageUrl {
                        APIService.instance.getUserImage(url: url) { success, image in
                            completion(userModel, image)
                        }
                    }
                    completion(userModel, nil)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(nil, nil)
                }
                
                completion(nil, nil)
            }
        }
    }
    
    func editUser(user: User, userImage: UIImage, completion: @escaping (Bool) -> Void) {
        uploadUserImage(userId: user.id, image: userImage) { success, url in
            if success {
                var userToUpdate = user
                userToUpdate.imageUrl = url
                self.db.collection("users").document(user.id).updateData(userToUpdate.asDictionary()) { error in
                    if let error = error {
                        print("Error updating user: \(error)")
                        
                    }
                    completion(true)
                }
            }
            completion(false)
        }
        completion(false)
    }
    
    func uploadUserImage(userId: String, image: UIImage, completion: @escaping (Bool, String?) -> Void) {
        guard let imageData = image.pngData() else {
            return
        }
        storageRef.child("userImages/\(userId).png").putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            self.storageRef.child("userImages/\(userId).png").downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("check url \(urlString)")
                completion(true, urlString)
            }
        }
        completion(false, nil)
    }
    
    func getUserWithPost() {
        db.collection("users").getDocuments { (snapshot, error) in
            
        }
    }
}
