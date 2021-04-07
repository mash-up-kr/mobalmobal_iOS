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
            print("cell 의 모델이 세팅됨.")
            delegate?.setUIFromModel()
        }
    }
    func refViewModel(_ model: ProfileResponse?) {
        print("cell set model")
        self.model = model
    }
}
