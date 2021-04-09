//
//  MainViewModel.swift
//  MobalMobal
//
//  Created by 이재성 on 2021/04/09.
//

import Foundation

class MainViewModel {
    // MARK: - property
    var posts: [Post] = []
    
    // MARK: - API Method
    func callMainInfoApi(item: Int, limit: Int, completion: @escaping (Result<Void, DoneError>) -> Void) {
        DoneProvider.getMain(item: item, limit: limit) { response in
            self.posts = response.data.posts
            completion(.success(()))
        } failure: { (error) in
            print(error)
            completion(.failure(.unknown))
        }
    }
}
