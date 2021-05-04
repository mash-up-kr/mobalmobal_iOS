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
    var myInprogressModel: [MydonationPost]? {
        didSet {
            delegate?.setMyDonationUI()
        }
    }
    var myExpiredModel: [MydonationPost]? {
        didSet {
            delegate?.setMyDonationUI()
        }
    }
    var myDonateModel: [Donate]? {
        didSet {
            delegate?.setMyDonateUI()
        }
    }
    func setMyDonateModel(_ model: [Donate]) {
        self.myDonateModel = model
    }
    func setMyInprogressModel(_ model: [MydonationPost]) {
        self.myInprogressModel = model
    }
    func setMyExpiredModel(_ model: [MydonationPost]) {
        self.myExpiredModel = model
    }
    // postId 중복 체
    func getMyDonateModelCount() -> Int? {
        myDonateModel?.count
    }
    func getMyInprogressModelCount() -> Int? {
        myInprogressModel?.count
    }
    func getMyExpiredModelCount() -> Int? {
        myExpiredModel?.count
    }
    
}
