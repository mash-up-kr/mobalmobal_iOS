//
//  ProfileMydonationViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/08.
//

import Foundation

protocol ProfileMydonationViewModelDelegate: AnyObject {
    func setMyDonationUI()
    func setMyDonateUI()
}

// 내가 만든 도네이션 (내가 연 도네, 종료된 도네) MyDonation
// 내가 후운한 돈데 MyDonate
class ProfileMydonationViewModel {
    // MARK: - Properties
    weak var delegate: ProfileMydonationViewModelDelegate?
    var myDonationModel: MydonationData? {
        didSet {
            delegate?.setMyDonationUI()
        }
    }
    var myDonateModel: MyDonates? {
        didSet {
            delegate?.setMyDonateUI()
        }
    }
    func setMyDonateModel(_ model: MyDonates?) {
        self.myDonateModel = model
    }
    func setMyDonationModel(_ model: MydonationData?) {
        self.myDonationModel = model
    }
    // postId 중복 체
    func getMyDonatePostsNumber() -> Int {
        var postIdSet: Set<Int> = Set<Int>()
        guard let donates = myDonateModel?.donate else { return 0 }
        for post in donates {
            postIdSet.insert(post.postId)
        }
        return postIdSet.count
    }
    func getMyDonationPosts() -> [MydonationPost]? {
        myDonationModel?.posts
    }
    // 종료된도네 파악
    // true -> 종료
    func checkOutDated(postNumber: Int) -> Bool {
        guard let endDate = myDonationModel?.posts[postNumber].endAt else {
            return false
        }
        return Date().getDueDay(of: endDate) < 0 ? true : false
    }
}
