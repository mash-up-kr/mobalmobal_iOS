//
//  SignupUser.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/04/11.
//

import Foundation

struct SignupUser: Codable {
    var nickname: String
    var provider: String
    var fireStoreId: String
    var phoneNumber: String?
    var accountNumber: String?
    var bankName: String?
    var profileImage: String?
    var cash: Int?
    
    init(nickname: String, provider: String, fireStoreId: String) {
        self.nickname = nickname
        self.provider = provider
        self.fireStoreId = fireStoreId
    }
}
