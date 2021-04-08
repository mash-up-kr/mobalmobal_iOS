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
    // MARK: - Properties
    weak var delegate: ProfileMydonationViewModelDelegate?
    var model: MydonationResponse? {
        didSet {
            delegate?.setUIFromModel()
        }
    }
    func setModel(_ model: MydonationResponse?) {
        self.model = model
    }
    
    func getPosts() -> [MydonationPost]? {
        model?.data.posts
    }
    // 종료된도네 파악
    // true -> 종료
    func checkOutDated(postNumber: Int) -> Bool {
        guard let endDate = model?.data.posts[postNumber].endAt else {
            return false
        }
        return Date().getDueDay(of: endDate) < 0 ? true : false
    }
}
