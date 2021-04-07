//
//  ProfileDonatingViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/08.
//

import Foundation

protocol ProfileDonatingViewModelDelegate: AnyObject {
    func setUIFromModel(row: Int)
}
class ProfileDonatingViewModel {
    weak var delegate: ProfileDonatingViewModelDelegate?
    var giveEndDonationModel: MydonationPost? {
        didSet {
            print("donating table에서 내 도네이션관련")
            delegate?.setUIFromModel(row: row)
        }
    }
    var row: Int = 0
    func setGiveEndModel(_ model: MydonationResponse?, row: Int) {
        self.giveEndDonationModel = model?.data.posts[row]
        self.row = row
        print("현재 row 번호", row)
    }
    func getDonationImg(row: Int) -> String? {
        giveEndDonationModel?.postImage
    }
    func getGoal(row: Int) -> Int? {
        giveEndDonationModel?.goal
    }
    func getTitle(row: Int) -> String? {
        giveEndDonationModel?.title
    }
    func getDate(row: Int) -> Date? {
        giveEndDonationModel?.endAt
    }
}
