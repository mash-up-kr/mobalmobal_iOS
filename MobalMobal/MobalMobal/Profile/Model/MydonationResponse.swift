//
//  MydonationResponse.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/05.
//

import Foundation

struct MydonationResponse: Codable {
    let code: Int
    let data: MydonationData
}

struct MydonationData: Codable {
    let posts: [MydonationPost]
}

struct MydonationPost: Codable {
    let postId: Int
    let userId: Int
    let title: String
    let description: String?
    let goal: Int
    let currentAmount: Int
    let startedAt: Date
    let endAt: Date
    let postImage: String?
    let createdAt: Date?
    let updatedAt: Date?
    let deletedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case userId = "user_id"
        case startedAt = "started_at"
        case endAt = "end_at"
        case postImage = "post_image"
        case deletedAt = "deleted_at"
        case currentAmount = "current_amount"
        case title, description, goal, createdAt, updatedAt
    }
}
