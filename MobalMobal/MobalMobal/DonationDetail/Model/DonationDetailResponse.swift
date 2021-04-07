//
//  DonationDetailResponse.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/07.
//

import Foundation

struct DetailData: Codable {
    let postId: Int
    let userId: Int
    let title: String
    let description: String
    let goal: Int
    
    // 추후 Date 타입은 number 타입으로 내려오게 마이그레이션 해야함
    let startedAt: String
    let endAt: String
    let postImage: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String
    
    enum CodingKeys: String, CodingKey {
        case title, description, goal
        case postId = "post_id"
        case userId = "user_id"
        case startedAt = "started_at"
        case endAt = "end_at"
        case postImage = "post_image"
        case createdAt, updatedAt, deletedAt
    }
}

enum ResponseState: Int, Codable {
    case success = 200
    case missingParam = 400
}

struct DonationDetailResponse: Codable {
    let code: ResponseState
    let data: DetailData?
    let message: String?
}
