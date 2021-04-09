//
//  MyDonateResponse.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/10.
//

import Foundation

struct MyDonateResponse: Codable {
    let code: Int
    let data: MyDonates
}
struct MyDonates: Codable {
    let donate: [Donate]
}

struct Donate: Codable {
    let donateId: Int
    let userId: Int
    let postId: Int
    let amount: Int
    let createdAt: Date?
    let updatedAt: Date?
    let deletedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case donateId = "donate_id"
        case userId = "user_id"
        case postId = "post_id"
        case amount, createdAt, updatedAt, deletedAt
    }
}
