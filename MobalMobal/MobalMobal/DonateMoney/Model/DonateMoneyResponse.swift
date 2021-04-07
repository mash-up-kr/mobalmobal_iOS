//
//  DonateMoneyResponse.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/08.
//

import Foundation

enum DonateResponseCode: Int, Codable {
    case success = 201
    case badRequest = 400
}

struct DonateMoneyResponse: Codable {
    let code: DonateResponseCode
    let message: String?
}
