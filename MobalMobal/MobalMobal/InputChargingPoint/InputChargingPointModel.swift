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
    let chargedAt: Int
    let userID: Int
    let updatedAt: String
    let createdAt: String
}
