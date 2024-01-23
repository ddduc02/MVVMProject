//
//  APIService.swift
//  MVVMProject
//
//  Created by ducdo on 16/01/2024.
//

import Foundation
import Alamofire
import AlamofireImage
import UIKit

class APIService {
    static let instance = APIService()
    private init() {}
    let url = "https://jsonplaceholder.typicode.com/"
    func getPosts(completion : @escaping (([Post], Error?) -> Void)) {
        guard let url = URL(string: url + "posts") else {
            print("error")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("data error")
                return
            }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(posts, nil)
            } catch {
                completion([], error)
            }
        }.resume()
    }
    
    func getUserImage(url: String, completion: @escaping (Bool, UIImage?) ->Void ) {
        AF.request(url).responseImage { response in
          if case .success(let image) = response.result {
            completion(true, image)
          }
        }
        completion(false, nil)
    }
}
