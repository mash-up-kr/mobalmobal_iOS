//
//  DoneService.swift
//  MobalMobal
//
//  Created by 이재성 on 2021/04/09.
//

import Foundation
import Moya

enum DoneService {
    case login(fireStoreId: String)
    case getMain(item: Int, limit: Int)
    case getDetail(posts: Int)
    case getUserProfile
    case getMyDonation
    case getMyDonate
}

extension DoneService: TargetType {
    var sampleData: Data {
        Data()
    }
    
    var baseURL: URL {
        return URL(string: "http://13.125.168.51:3000")!
    }
    
    var path: String {
        switch self {
        case .getMain:
            return "/posts"
        case .login:
            return "/users/login"
        case .getDetail(let posts):
            return "/posts/\(posts)"
        case .getUserProfile:
            return "/users"
        case .getMyDonation:
            return "/posts/my"
        case .getMyDonate:
            return "/donate/my"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMain, .getDetail, .getUserProfile, .getMyDonation, .getMyDonate:
            return .get
        case .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getMain(let item, let limit):
            return .requestParameters(parameters: ["item": item,
                                                   "limit": limit,
                                                   "order": "ASC"], encoding: URLEncoding.queryString)
        case .getDetail, .getUserProfile, .getMyDonation, .getMyDonate:
            return .requestPlain
        case .login(let fireStoreId):
            return .requestParameters(parameters: ["fireStoreId": fireStoreId], encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
        case .login:
            return nil
        case .getMain, .getDetail, .getUserProfile, .getMyDonation, .getMyDonate:
//            guard let token = token else { return nil }
            return ["authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2MTc3ODIzNzgsImV4cCI6MTY0OTMzOTk3OCwiaXNzIjoiaHllb25pIn0.EylJ0O9zsOePeB6WmQ5-Xfm6X63L29s6iUxZL6dxzdA"]
        }
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
