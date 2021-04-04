//
//  ProfileViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/02.
//

import Alamofire
import Foundation

class ProfileViewModel {
    // MARK: - Properties
    private let headerKey: String = "authorization"
    var tokenID: Any?       // UserDefault로 받아올 값
    private var profileResponseModel: ProfileResponse?
    
    // MARK: - Methods
    private func getProfile() {
        let profileURL: String = "http://13.125.168.51:3000/users"
        let params: Parameters = [headerKey: tokenID]
        let decoder: JSONDecoder = JSONDecoder()
        
        AF.request(profileURL, method: .get, parameters: params, encoding: JSONEncoding.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                do {
                    let data: Data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    guard let profileResponse: ProfileResponse = try? decoder.decode(ProfileResponse.self, from: data) else { return }
                    
                    if profileResponse.code == 200 {
                        self?.profileResponseModel = profileResponse
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
        profileResponseModel?.data?.user?.nickname
    }
    func getUserCash() -> Int? {
        profileResponseModel?.data?.user?.cash
    }
    func getUserProfileImage() -> String? {
        profileResponseModel?.data?.user?.profileImage
    }
}
