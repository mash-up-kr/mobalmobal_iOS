//
//  DonateData.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/09.
//

import Foundation

struct DonateMoney: Codable {
    let postId: Int
    let userId: Int
    let amount: Int
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case userId = "user_id"
        case amount
    }
}
struct DonateMoneyData: Codable {
    let donate: DonateMoney?
}
