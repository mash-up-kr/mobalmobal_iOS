//
//  CreateDonation.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/05/04.
//

import Foundation

struct CreateDonation: Codable {
    var title: String
    var description: String?
    var postImage: String
    var goal: Int
    var startedAt: Date
    var endAt: Date
    
    enum CodingKeys: String, CodingKey {
        case title, description
        case postImage = "post_image"
        case goal
        case startedAt = "started_at"
        case endAt = "end_at"
    }
}
