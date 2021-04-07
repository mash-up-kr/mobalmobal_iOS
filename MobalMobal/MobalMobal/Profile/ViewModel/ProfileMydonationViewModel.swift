//
//  ProfileMydonationViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/08.
//

import Foundation

protocol ProfileMydonationViewModelDelegate: AnyObject {
    func setUIFromModel()
}
class ProfileMydonationViewModel {
    weak var delegate: ProfileMydonationViewModelDelegate?
    var model: MydonationResponse? {
        didSet {
            print("my donation response viewmodel에 들어옴")
            delegate?.setUIFromModel()
        }
    }
    func setModel(_ model: MydonationResponse?) {
        print("mydonation cell set model")
        self.model = model
    }
    
    func getPosts() -> [MydonationPost]? {
        model?.data.posts
    }
}
