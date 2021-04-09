//
//  ProfileDonatingViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/08.
//

import Foundation

protocol ProfileDonatingViewModelDelegate: AnyObject {
    func setUIFromModel()
}
class ProfileDonatingViewModel {
    weak var delegate: ProfileDonatingViewModelDelegate?
    var giveEndDonationModel: MydonationPost? {
        didSet {
            delegate?.setUIFromModel()
        }
    }
    var row: Int = 0
    func setGiveEndModel(_ rowData: MydonationPost) {
        self.giveEndDonationModel = rowData
    }
    func getDonationImg() -> String? {
        giveEndDonationModel?.postImage
    }
    func getGoal() -> Int? {
        giveEndDonationModel?.goal
    }
    func getTitle() -> String? {
        giveEndDonationModel?.title
    }
    func getDate() -> Date? {
        giveEndDonationModel?.endAt
    }
    func getCurrentAmount() -> Int? {
        giveEndDonationModel?.currentAmount
    }
}
