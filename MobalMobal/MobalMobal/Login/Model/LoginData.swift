//
//  LoginData.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/01.
//

import Foundation

struct UserToken: Codable {
    let token: String
    let refreshToken: String
}

struct LoginData: Codable {
    let token: UserToken
}
