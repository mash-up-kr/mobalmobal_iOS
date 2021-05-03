//
//  CreateDonationPost.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/05/04.
//

import Foundation

struct CreateDonationResponse: Codable {
    let code: Int
    let data: CreateDonationData
}

struct CreateDonationData: Codable {
    let postId: Int
    let userId: Int
    let title: String
    let description: String
    let goal: Int
    let startedAt: Date
    let endAt: Date
    let postImage: String
    let currentAmount: Int
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case userId = "user_id"
        case title, description, goal
        case startedAt = "started_at"
        case endAt = "end_at"
        case postImage = "post_image"
        case currentAmount = "current_amount"
    }
}
