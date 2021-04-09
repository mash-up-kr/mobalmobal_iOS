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
    
    weak var mainDelegate: ProfileViewModelDelegate?
    var profileResponseModel: ProfileData? {
        didSet {
            mainDelegate?.tableViewUpdate()
        }
    }

    var mydonationResponseModel: MydonationData? {
        didSet {
            mainDelegate?.tableViewUpdate()
        }
    }
    
    private let decoder: JSONDecoder = JSONDecoder()
    // MARK: - Methods
    func getProfileResponse() {
        DoneProvider.getUserProfile() { [weak self] response in
            self?.profileResponseModel = response.data
        } failure: { err in
            print(err.localizedDescription)
        }
    }

    func getMydontaionResponse() {
        print("get mydonation response")
        DoneProvider.getMyDonation { [weak self] response in
            self?.mydonationResponseModel = response.data
        } failure: { err in
            print(err.localizedDescription)
        }

    }
    
    func checkSuccess(code: Int) -> Bool {
        code == 200 ? true : false
    }
    
    func getUserNickname() -> String? {
        profileResponseModel?.user.nickname
    }
    func getUserCash() -> Int? {
        profileResponseModel?.user.cash
    }
    func getUserProfileImage() -> String? {
        profileResponseModel?.user.profileImage
    }
    func getMydonation() -> MydonationData? {
        mydonationResponseModel
    }
    func checkOutDated(date: Date) -> Bool {
        // 날자가 지났으면 true반환 종료된도네에 넣는다.
        Date().getDueDay(of: date) < 0 ? true : false
    }
}
