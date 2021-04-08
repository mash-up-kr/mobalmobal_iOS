//
//  ProfileCellViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/07.
//

import Foundation

protocol ProfileCellViewModelDelegate: AnyObject {
    func setUIFromModel()
}

class ProfileCellViewModel {
    weak var delegate: ProfileCellViewModelDelegate?
    var model: ProfileResponse? {
        didSet {
            delegate?.setUIFromModel()
        }
    }
    func setModel(_ model: ProfileResponse?) {
        self.model = model
    }
    func getCash() -> Int? {
        self.model?.data.user.cash
    }
    func getNickname() -> String? {
        self.model?.data.user.nickname
    }
    func getProfileImg() -> String? {
        self.model?.data.user.profileImage
    }
}
