//
//  InputChargingPointModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/08.
//

import Foundation

struct InputChargingPointResponse: Codable {
    let code: Int
    let data: ChargingData
}
struct ChargingData: Codable {
    let charge: ChargeInfo
}
struct ChargeInfo: Codable {
    let isCharge: Int
    let chargeID: Int
    let amount: Int
    let userName: String
    let chargedAt: Date
    let userID: Int
    let updatedAt: Date?
    let createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case isCharge = "is_charge"
        case chargeID = "charge_id"
        case userName = "user_name"
        case chargedAt = "charged_at"
        case userID = "user_id"
        case amount, updatedAt, createdAt
    }
}
