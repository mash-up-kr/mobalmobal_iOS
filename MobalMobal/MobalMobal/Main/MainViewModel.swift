//
//  MainViewModel.swift
//  MobalMobal
//
//  Created by 이재성 on 2021/04/09.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func didNicknameChanged(to nickname: String?)
    func didPostsChanged(to posts: [MainPost])
    func didMyDonationsChanged(to myDonations: [MydonationPost])
    
    func failedGetPosts(message: String)
    func failedGetMyDonations(message: String)
}

class MainViewModel {
    // MARK: - property
    var nickname: String? {
        didSet {
            mainViewModelDelegate?.didNicknameChanged(to: nickname)
        }
    }
    var posts: [MainPost] = [] {
        didSet {
            mainViewModelDelegate?.didPostsChanged(to: posts)
        }
    }
    var myDonations: [MydonationPost] = [] { //진행 중인 내 도네이션
        didSet {
            mainViewModelDelegate?.didMyDonationsChanged(to: myDonations)
        }
    }
    
    var limit: Int = 10
    var item: Int = Int.max
    var isEnd: Bool = false

    weak var mainMyOngoingDelegate: MainMyOngoingDonationDelegate?
    weak var mainViewModelDelegate: MainViewModelDelegate?
    
    var getMyDonationsCount: Int {
        return myDonations.count
    }
    // MARK: - API Method
    
    func callUserInfoApi() {
        // check keychain user token
        if let token = KeychainManager.getUserToken() {
            UserInfo.shared.token = token
            DoneProvider.getUserProfile { [weak self] response in
                guard let user = response.data?.user else { return }
                UserInfo.shared.updateUserInfo(data: user)
                self?.nickname = user.nickname
            } failure: { _ in return }
        }
    }
    
    func callMainPostsApi() {
        DoneProvider.getMain(item: item, limit: limit) { [weak self] response in
            guard let self = self else { return }
            
            if response.code != 200 {
                self.mainViewModelDelegate?.failedGetPosts(message: "데이터를 불러올 수 없습니다. \(response.message!)")
                return
            }
            
            guard let posts = response.data?.posts else { return }
            if self.posts.isEmpty {
                self.posts = posts
            } else {
                if posts.isEmpty {  self.isEnd = true }
                self.posts.append(contentsOf: posts)
            }
        } failure: { (error) in
            self.mainViewModelDelegate?.failedGetPosts(message: "데이터를 불러올 수 없습니다. \(error.localizedDescription)")
        }
    }
    
    func callMyDonationAPI(completion: @escaping (Result<Void, DoneError>) -> Void ) {
        DoneProvider.getMyDonation(status: "IN_PROGRESS") { [weak self] response in
            guard let posts = response.data?.posts else {
                completion(.failure(.unknown))
                return
            }
            self?.checkInprogressDonation(posts)
            self?.mainMyOngoingDelegate?.populate()
            completion(.success(()))
        } failure: { err in
            print(err.localizedDescription)
            completion(.failure(.unknown))
        }
    }
    
    // MARK: - Methods
    func checkInprogressDonation(_ response: [MydonationPost]) {
        for post in response {
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
        if myDonations[item].goal == 0 { return 100.0 }
        return Float(Float(( myDonations[item].currentAmount * 100 )) / Float(myDonations[item].goal))
    }
}
