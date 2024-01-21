//
//  HomeViewModel.swift
//  MVVMProject
//
//  Created by ducdo on 15/01/2024.
//

import Foundation

class HomeViewModel {
    var posts : Binding<[Post]>
    init() {
        self.posts = Binding<[Post]>(value: [])
        self.getPosts()
    }
    
    func getPosts() {
        APIService.instance.getPosts { [weak self] posts, error in
            self?.postsChanged(posts)
            print(error ?? "")
        }
    }
    
    func postsChanged(_ newValue : [Post]) {
        posts.value = newValue
    }

}
