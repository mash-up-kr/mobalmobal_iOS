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
    let postImage: String?
    let title: String
    let description: String?
    let goal: Int
    let current: Int
    
    let startedDate: Date?
    let endDate: Date?
    let createdDate: Date?
    let updatedDate: Date?
    let deletedDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case userId = "user_id"
        case postImage = "post_image"
        case title, description, goal
        case current = "current_amount"
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
