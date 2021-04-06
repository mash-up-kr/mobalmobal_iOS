//
//  LoginResponse.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/01.
//

import Foundation

struct UserToken: Codable {
    let token: String // user defaults -> API header에 담아서 보내야함
    let refreshToken: String
}

struct LoginData: Codable {
    let token: UserToken
}

struct LoginResponse: Codable {
    enum ResponseState: Int, Codable {
        case success = 200
        case unknownAccount = 404
        case missingParam = 400
    }
    let data: LoginData?
    let code: ResponseState
        // 로그인 성공 : 200
        // 회원정보 없음 : 404
        // 인자값 부정확 : 400
    let message: String
}

// 앱실행 -> 로그인 -> 회원가입
// -> 메인

// 스플래쉬 -> 저장된 토큰 있으면 -> 메인
// -> 없으면 -> 로그인화면
// 로그아웃 -> 토큰 삭제
