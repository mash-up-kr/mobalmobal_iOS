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
    var model: ProfileData? {
        didSet {
            delegate?.setUIFromModel()
        }
    }
    func setModel(_ model: ProfileData?) {
        self.model = model
    }
    func getCash() -> Int? {
        self.model?.user.cash
    }
    func getNickname() -> String? {
        self.model?.user.nickname
    }
    func getProfileImg() -> String? {
        self.model?.user.profileImage
    }
}
