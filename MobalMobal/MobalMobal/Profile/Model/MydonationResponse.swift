//
//  MydonationResponse.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/05.
//

import Foundation

struct MydonationResponse: Codable {
    let data: MydonationData?
    let code: Int
}

struct MydonationData: Codable {
    let post: [MydontaionPost]
}

struct MydontaionPost: Codable {
    let postId: Int
    let userId: Int
    let title: String
    let description: String?
    let goal: Int
    let startedAt: String
    let endAt: String
    let postImage: String?
    let createdAt: String
    let updatedAt: String
    let deletedAt: String
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case userId = "user_id"
        case startedAt = "started_at"
        case endAt = "end_at"
        case postImage = "post_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case title, description, goal
    }
}
