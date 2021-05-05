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
    var goal: String
    var startedAt: String
    var endAt: String
    var postImageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case title, description, postImageData
        case postImage = "post_image"
        case goal
        case startedAt = "started_at"
        case endAt = "end_at"
    }
}
