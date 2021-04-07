//
//  ProfileViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/02.
//

import Alamofire
import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func tableViewUpdate()
}
//protocol ProfileCellViewModelDelegate: AnyObject {
//    func setUIFromModel()
//}
class ProfileViewModel {
    // MARK: - Properties
    private let headerKey: String = "authorization"
    var tokenID: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2MTc3ODIzNzgsImV4cCI6MTY0OTMzOTk3OCwiaXNzIjoiaHllb25pIn0.EylJ0O9zsOePeB6WmQ5-Xfm6X63L29s6iUxZL6dxzdA"      // UserDefault로 받아올 값
    weak var mainDelegate: ProfileViewModelDelegate?
//    weak var profileCellDelegate: ProfileCellViewModelDelegate?
    var profileResponseModel: ProfileResponse? {
        didSet {
            print("model set!!")
            print(profileResponseModel ?? "no")
            print(profileResponseModel?.data.user.cash)
//            profileCellDelegate?.setUIFromModel()
            mainDelegate?.tableViewUpdate()
        }
    }
    private var mydonationResponseModel: MydonationResponse?
    private lazy var headers: HTTPHeaders = [headerKey: tokenID]
    
    // MARK: - Methods
    func getProfileResponse() {
        print("get profile response")
        let profileURL: String = "http://13.125.168.51:3000/users"
        print(headers)
        AF.request(profileURL, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                do {
                    let data: Data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    
                    let profileResponse: ProfileResponse = try JSONDecoder().decode(ProfileResponse.self, from: data)
                    
                    if profileResponse.code == 200 {
                        print("model setting")
                        self?.profileResponseModel = profileResponse
                        print(self?.profileResponseModel, "fail??")
                        print(self?.getUserNickname())
                    } else {
                        print("code fail")
                        return
                    }
                } catch let error {
                    print(error.localizedDescription, "1")
                }
            case .failure(let error):
                print(error.localizedDescription, "2")
            }
        }
    }
    func getMydontaionResponse() {
        print("get mydonation response")
        let mydontaionURL: String = "http://13.125.168.51:3000/posts/my"
        
        AF.request(mydontaionURL, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                do {
                    let data: Data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let mydonationResponse: MydonationResponse = try JSONDecoder().decode(MydonationResponse.self, from: data)
                    
                    if mydonationResponse.code == 200 {
                        self?.mydonationResponseModel = mydonationResponse
                    } else { return }
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkSuccess(code: Int) -> Bool {
        code == 200 ? true : false
    }
    
    func getUserNickname() -> String? {
        profileResponseModel?.data.user.nickname
    }
    func getUserCash() -> Int? {
        profileResponseModel?.data.user.cash
    }
    func getUserProfileImage() -> String? {
        profileResponseModel?.data.user.profileImage
    }
    func getMydonation() -> MydonationData? {
        mydonationResponseModel?.data
    }
}
