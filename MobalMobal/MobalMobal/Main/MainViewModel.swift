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
    
    func failedGetPosts(message: String)
    func failedGetMyDonations(message: String)
}

protocol MainMyOngoingDonationDelegate: AnyObject {
    func didMyDonationsChanged()
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
    var myDonations: [MydonationPost] = [] {
        didSet {
            mainMyOngoingDelegate?.didMyDonationsChanged()
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
                self.mainViewModelDelegate?.failedGetPosts(message: "진행중 데이터를 불러올 수 없습니다. \(response.message!)")
                return
            }
            
            guard let posts = response.data?.posts else { return }
            if self.posts.isEmpty {
                self.posts = posts
            } else {
                if posts.isEmpty {  self.isEnd = true }
                self.posts += posts
            }
        } failure: { error in
            self.mainViewModelDelegate?.failedGetPosts(message: "진행중 데이터를 불러올 수 없습니다. \(error.localizedDescription)")
        }
    }
    
    func callMyDonationAPI() {
        DoneProvider.getMyDonation(status: "IN_PROGRESS") { [weak self] response in
            guard let self = self else { return }
            
            if response.code != 200 {
                self.mainViewModelDelegate?.failedGetPosts(message: "나의 진행 데이터를 불러올 수 없습니다. \(response.message!)")
                return
            }
            
            guard let posts = response.data?.posts else { return }
            self.myDonations += posts
        } failure: { error in
            self.mainViewModelDelegate?.failedGetPosts(message: "나의 진행 데이터를 불러올 수 없습니다. \(error.localizedDescription)")
        }
        DoneProvider.getMyDonation(status: "BEFORE") { [weak self] response in
            guard let self = self else { return }
            
            if response.code != 200 {
                self.mainViewModelDelegate?.failedGetPosts(message: "나의 진행 데이터를 불러올 수 없습니다. \(response.message!)")
                return
            }
            guard let posts = response.data?.posts else { return }
            self.myDonations += posts
        } failure: { error in
            self.mainViewModelDelegate?.failedGetPosts(message: "나의 진행 데이터를 불러올 수 없습니다. \(error.localizedDescription)")
        }

    }
    
    // MARK: - Methods
    func getMyDontion(at item: Int) -> MydonationPost {
        return myDonations[item]
    }
    
    func reset() {
        limit = 10
        item = Int.max
        isEnd = false
        posts = []
        myDonations = []
    }
}
