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
    var myDonations: [MydonationPost] = []  //진행 중인 내 도네이션
    var limit: Int = 10
    var item: Int = Int.max
    var isEnd: Bool = false
    weak var delegate: MainMyOngoingDonationDelegate?
    
    var getMyDonationsCount: Int {
        return myDonations.count
    }
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
    
    func callMyDonationAPI(completion: @escaping (Result<Void, DoneError>) -> Void ) {
        DoneProvider.getMyDonation { [weak self] response in
            guard let posts = response.data?.posts else {
                completion(.failure(.unknown))
                return
            }
            self?.checkInprogressDonation(posts)
            self?.delegate?.populate()
            completion(.success(()))
        } failure: { err in
            print(err.localizedDescription)
            completion(.failure(.unknown))
        }
    }
    
    // MARK: - Methods
    func checkInprogressDonation(_ response: [MydonationPost]) {
        for post in response{
            // 날짜가 지났으면 true반환 -> expired에넣음
            if Date().getDueDay(of: post.endAt) >= 0 {
                self.myDonations.append(post)
            }
        }
    }
    func getMyDonationTitle(_ item: Int) -> String {
        return myDonations[item].title
    }
    func getMyDonationMoney(_ item: Int) -> Int {
        return myDonations[item].currentAmount
    }
    func getMyDonationProgress(_ item: Int) -> Float {
        var progress: Float = 0.0
        progress = Float(Float(( myDonations[item].currentAmount * 100 )) / Float(myDonations[item].goal))
        return progress
    }
}
