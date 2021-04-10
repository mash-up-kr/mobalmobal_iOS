//
//  ProfileResponse.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/02.
//

import Foundation

struct ProfileResponse: Codable {
    let data: ProfileData
    let code: Int
//    let message: String?
        // 요청 실패일 때만 메세지존재
}

struct ProfileData: Codable {
    let user: ProfileUser
}

struct ProfileUser: Codable {
    let userId: Int
    let nickname: String
    let phoneNumber: String?
    let accountNumber: String?
    let bankName: String?
    let profileImage: String?
    let cash: Int
    let firestoreId: String
    let provider: String
    let createdAt: Date?
    let updatedAt: Date?
    let deletedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case phoneNumber = "phone_number"
        case bankName = "bank_name"
        case accountNumber = "account_number"
        case profileImage = "profile_image"
        case firestoreId = "firestore_id"
        case nickname, cash, provider, createdAt, updatedAt, deletedAt
    }
}
