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
    case signup(signupUser: SignupUser)
    case getMain(item: Int, limit: Int)
    case getDetail(posts: Int)
    case donate(post: Int, money: Int)
    case createDonation(donation: CreateDonation)
    case getUserProfile
    case getMyDonation(status: String)
    case getMyDonate
    case charge(amount: Int, userName: String, chargedAt: String)
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
        case .signup:
            return "/users"
        case .getDetail(let posts):
            return "/posts/\(posts)"
        case .donate:
            return "/donate"
        case .getUserProfile:
            return "/users"
        case .getMyDonation:
            return "/posts/my"
        case .getMyDonate:
            return "/donate/my"
        case .charge:
            return "/charge"
        case .createDonation:
            return "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMain, .getDetail, .getUserProfile, .getMyDonation, .getMyDonate:
            return .get

        case .login, .donate, .charge, .createDonation, .signup:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getMain(let item, let limit):
            return .requestParameters(parameters: ["item": item,
                                                   "limit": limit,
                                                   "order": "DESC"], encoding: URLEncoding.queryString)
        case .getDetail, .getUserProfile, .getMyDonate:
            return .requestPlain
        case .login(let fireStoreId):
            return .requestParameters(parameters: ["fireStoreId": fireStoreId], encoding: JSONEncoding.default)
        case .signup(let signupUser):
            return .requestParameters(parameters: ["nickname": signupUser.nickname,
                                                   "provider": signupUser.provider,
                                                   "fireStoreId": signupUser.fireStoreId,
                                                   "phoneNumber": signupUser.phoneNumber,
                                                   "accountNumber": signupUser.accountNumber,
                                                   "bankName": signupUser.bankName,
                                                   "profileImage": signupUser.profileImage,
                                                   "cash": signupUser.cash
                                                   
            ], encoding: JSONEncoding.default)
        case .donate(let post, let money):
            return .requestParameters(parameters: ["post_id": post, "amount": money], encoding: JSONEncoding.default)
        case .charge(let amount, let userName, let chargedAt):
            return .requestCompositeParameters(bodyParameters: ["amount": amount,
                                                                "user_name": userName,
                                                                "charged_at": chargedAt]
                                               , bodyEncoding: JSONEncoding.default
                                               , urlParameters: [:])
        case .createDonation(let donation):
            let titleData = MultipartFormData(provider: .data(donation.title.data(using: .utf8)!), name: "title")
            let descriptionData = MultipartFormData(provider: .data(donation.description!.data(using: .utf8)!), name: "description")
            let imageData = MultipartFormData(provider: .data(donation.postImageData!), name: "post_image", fileName: "image.png", mimeType: "image/png")
            let goalData = MultipartFormData(provider: .data(String(donation.goal).data(using: .utf8)!), name: "goal")
            let startedData = MultipartFormData(provider: .data(donation.startedAt.data(using: .utf8)!), name: "started_at")
            let endData = MultipartFormData(provider: .data(donation.endAt.data(using: .utf8)!), name: "end_at")
            let multipartData = [titleData, descriptionData, imageData, goalData, startedData, endData]

            return .uploadMultipart(multipartData)
        case .getMyDonation(let status):
            return .requestParameters(parameters: ["status": status], encoding: URLEncoding.queryString)
        }
    }
        
    var headers: [String: String]? {
        switch self {
        case .login, .signup:
            return nil
        case .getMain, .getDetail, .donate, .getUserProfile, .getMyDonate, .getMyDonation, .charge, .createDonation:
            guard let token = KeychainManager.getUserToken() else {
                print("🐻 [Login Required] keychain token nil")
                return nil
            }
            print("🐻 keychain token : \(token)")
            return ["authorization": token]
//            return ["authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2MTc3ODIzNzgsImV4cCI6MTY0OTMzOTk3OCwiaXNzIjoiaHllb25pIn0.EylJ0O9zsOePeB6WmQ5-Xfm6X63L29s6iUxZL6dxzdA"]
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
