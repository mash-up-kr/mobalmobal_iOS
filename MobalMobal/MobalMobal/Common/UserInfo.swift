//
//  UserInfo.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/09.
//

import Foundation

class UserInfo {
    static let shared: UserInfo = UserInfo()
    
    var token: String?
    var fireStoreId: String?
    
    var userId: Int?
    var nickName: String?
    var profileImage: String?
    var phoneNumber: String?
    var accountNumber: String?
    var bankName: String?
    var cash: Int64?
}