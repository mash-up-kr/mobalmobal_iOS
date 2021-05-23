//
//  UserInfo.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/09.
//

import Foundation

enum Provider: String {
    case google, facebook, apple
}

class UserInfo {
    static let shared: UserInfo = UserInfo()
    var needToUpdate: Bool = false
    
    var token: String? {
        didSet { needToUpdate = true }
    }
    var provider: Provider?
    
    var fireStoreId: String?
    var userId: Int?
    var nickName: String?
    var profileImage: String? // url
    var phoneNumber: String?
    var accountNumber: String?
    var bankName: String?
    var cash: Int?
    
    func updateUserInfo(data user: ProfileUser?) {
        guard let user = user else { return resetUserInfo() }
        
        fireStoreId = user.firestoreId
        userId = user.userId
        nickName = user.nickname
        profileImage = user.profileImage
        phoneNumber = user.phoneNumber
        accountNumber = user.accountNumber
        bankName = user.bankName
        cash = user.cash
    }
    
    func resetUserInfo() {
        token = nil
        provider = nil
        fireStoreId = nil
        userId = nil
        nickName = nil
        profileImage = nil
        phoneNumber = nil
        accountNumber = nil
        bankName = nil
        cash = nil
    }
}
