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
class ProfileViewModel {
    // MARK: - Properties
    private let headerKey: String = "authorization"
    var tokenID: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2MTc3ODIzNzgsImV4cCI6MTY0OTMzOTk3OCwiaXNzIjoiaHllb25pIn0.EylJ0O9zsOePeB6WmQ5-Xfm6X63L29s6iUxZL6dxzdA"      // UserDefault로 받아올 값
    weak var mainDelegate: ProfileViewModelDelegate?
    var profileResponseModel: ProfileResponse? {
        didSet {
            print("model set!!")
    
//            profileCellDelegate?.setUIFromModel()
            mainDelegate?.tableViewUpdate()
        }
    }
    var mydonationResponseModel: MydonationResponse? {
        didSet {
        }
    }
    private lazy var headers: HTTPHeaders = [headerKey: tokenID]
    
    // MARK: - Methods
    func getProfileResponse() {
        let profileURL: String = "http://13.125.168.51:3000/users"
        AF.request(profileURL, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                do {
                    let data: Data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    
                    let profileResponse: ProfileResponse = try JSONDecoder().decode(ProfileResponse.self, from: data)
                    
                    if profileResponse.code == 200 {
                        self?.profileResponseModel = profileResponse
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
                        print(self?.mydonationResponseModel)
                    } else {
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
