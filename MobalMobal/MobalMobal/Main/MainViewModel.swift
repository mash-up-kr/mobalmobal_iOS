//
//  MainViewModel.swift
//  MobalMobal
//
//  Created by 이재성 on 2021/04/09.
//

import Foundation

class MainViewModel {
    // MARK: - property
    var posts: [MainPost] = []
    
    var limit: Int = 10
    var item: Int = Int.max
    var isEnd: Bool = false
    
    // MARK: - API Method
    func callMainInfoApi(completion: @escaping (Result<Void, DoneError>) -> Void) {
        DoneProvider.getMain(item: item, limit: limit) { response in
            guard let posts = response.data?.posts else {
                completion(.failure(.unknown))
                return
            }
            if self.posts.isEmpty {
                self.posts = posts
            } else {
                if posts.isEmpty {
                    self.isEnd = true
                }
                self.posts.append(contentsOf: posts)
            }
            completion(.success(()))
        } failure: { (error) in
            print(error)
            completion(.failure(.unknown))
        }
    }
}
