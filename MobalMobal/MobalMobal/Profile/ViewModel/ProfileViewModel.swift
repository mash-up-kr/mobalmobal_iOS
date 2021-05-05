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
    var profileResponseModel: ProfileData?
    var myInprogressResponseModel: [MydonationPost]?
    var myExpiredResponseModel: [MydonationPost]?
    var myDonateResponseModel: [Donate] = [Donate]()
    
    // MARK: - API call
    func getProfileResponse(completion: @escaping (Result<Void, DoneError>) -> Void) {
        DoneProvider.getUserProfile() { [weak self] response in
            switch response.code {
            case 200:
                self?.profileResponseModel = response.data
                completion(.success(()))
            default:
                completion(.failure(.client))
            }
        } failure: { err in
            print(err.localizedDescription)
            completion(.failure(.unknown))
        }
    }
    func getMyInprogressResponse(completion: @escaping (Result<Void, DoneError>) -> Void) {
        DoneProvider.getMyDonation(status: "IN_PROGRESS") { [weak self] response in
            switch response.code {
            case 200:
                self?.myInprogressResponseModel = response.data?.posts
                completion(.success(()))
            default:
                completion(.failure(.client))
            }
        } failure: { err in
            print(err.localizedDescription)
            completion(.failure(.unknown))
        }
    }
    func getMyExpiredResponse(completion: @escaping (Result<Void, DoneError>) -> Void) {
        DoneProvider.getMyDonation(status: "EXPIRED") { [weak self] response in
            switch response.code {
            case 200:
                self?.myExpiredResponseModel = response.data?.posts
                completion(.success(()))
            default:
                completion(.failure(.client))
            }
        } failure: { err in
            print(err.localizedDescription)
            completion(.failure(.unknown))
        }
    }
    func getMyDonateResponse(completion: @escaping (Result<Void, DoneError>) -> Void) {
        DoneProvider.getMyDonate { [weak self] response in
            switch response.code {
            case 200:
                self?.myDonateResponseDuplicateCheck(response)
                completion(.success(()))
            default:
                completion(.failure(.client))
            }
        } failure: { (err) in
            print(err.localizedDescription)
            completion(.failure((.unknown)))
        }
    }
    
    // MARK: - Methods
    
    // 후원중인도네 중복체크
    func myDonateResponseDuplicateCheck(_ response: ParseResponse<MyDonates>) {
        var donationPostId: Set<Int> = Set<Int>()
        for donate in response.data!.donate {
            if !donationPostId.contains(donate.postId) {
                donationPostId.insert(donate.postId)
                self.myDonateResponseModel.append(donate)
            }
        }
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
    func getMyDonate() -> [Donate]? {
        myDonateResponseModel
    }
    func getPostId(section: Int, row: Int) -> Int? {
        if section == 2 {
            return myInprogressResponseModel?[row].postId
        } else if section == 4 {
            return myExpiredResponseModel?[row].postId
        } else {
            return myDonateResponseModel[row].postId
        }
    }
}
