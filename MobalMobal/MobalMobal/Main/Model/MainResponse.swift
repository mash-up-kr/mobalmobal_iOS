//
//  MainResponse.swift
//  MobalMobal
//
//  Created by 이재성 on 2021/04/09.
//

import Foundation

// MARK: - MainResponse
struct MainResponse: Codable {
    let posts: [Post]
}

// MARK: - Post
struct Post: Codable {
    let postID, userID: Int
    let title: String
    let postDescription: String?
    let goal, currentAmount: Int
    let startedAt: Date
    let endAt: Date
    let postImage: String?
    let createdAt: Date?
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case userID = "user_id"
        case title
        case postDescription = "description"
        case goal
        case currentAmount = "current_amount"
        case startedAt = "started_at"
        case endAt = "end_at"
        case postImage = "post_image"
        case createdAt, updatedAt
    }
}
