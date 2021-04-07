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
    let postImage: String
    let title: String
    let description: String
    let goal: Int
//    let current: Int
    
    // 추후 Date 타입은 number 타입으로 내려오게 마이그레이션 해야함
    let startedDate: String
    let endDate: String
    let createdDate: String
    let updatedDate: String
    let deletedDate: String
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case userId = "user_id"
        case postImage = "post_image"
        case title, description, goal
//        case current = "current_amount"
        case startedDate = "started_at"
        case endDate = "end_at"
        case createdDate = "createdAt"
        case updatedDate = "updatedAt"
        case deletedDate = "deletedAt"
    }
}
struct DonationDetailData: Codable {
    let post: DetailData
}

enum ResponseState: Int, Codable {
    case success = 200
    case missingParam = 400
}

struct DonationDetailResponse: Codable {
    let code: ResponseState
    let data: DonationDetailData?
    let message: String?
}
