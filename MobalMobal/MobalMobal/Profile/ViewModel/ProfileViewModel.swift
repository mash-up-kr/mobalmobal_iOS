//
//  ProfileViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/02.
//

import Alamofire
import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func tableViewReload()
}
class ProfileViewModel {
    // MARK: - Properties
    weak var mainDelegate: ProfileViewModelDelegate?
    var profileResponseModel: ProfileData?
    var myInprogressResponseModel: [MydonationPost] = [MydonationPost]()
    var myExpiredResponseModel: [MydonationPost] = [MydonationPost]()
    var myDonateResponseModel: [Donate] = [Donate]()
    
    // MARK: - API call
    func getProfileResponse() {
        DoneProvider.getUserProfile() { [weak self] response in
            self?.profileResponseModel = response.data
        } failure: { err in
            print(err.localizedDescription)
        }
    }
    func getMydontaionResponse() {
        DoneProvider.getMyDonation { [weak self] response in
            self?.splitModelInprogressExpired(response)
        } failure: { err in
            print(err.localizedDescription)
        }
    }
    func getMyDonateResponse() {
        DoneProvider.getMyDonate { [weak self] response in
            self?.myDonateResponseDuplicateCheck(response)
        } failure: { (err) in
            print(err.localizedDescription)
        }
    }
    
    // 후원중인도네 중복체크
    func myDonateResponseDuplicateCheck(_ response: ParseResponse<MyDonates>) {
        var donationPostId: Set<Int> = Set<Int>()
        for donate in response.data!.donate {
            if !donationPostId.contains(donate.postId) {
                donationPostId.insert(donate.postId)
                self.myDonateResponseModel.append(donate)
            }
        }
        self.mainDelegate?.tableViewReload()
    }
    
    // 내가 연 도네를 Inprogress와 expired로 구분
    func splitModelInprogressExpired(_ response: ParseResponse<MydonationData>) {
        for post in response.data!.posts {
            // 날짜가 지났으면 true반환 -> expired에넣음
            if Date().getDueDay(of: post.endAt) < 0 {
                myExpiredResponseModel.append(post)
            } else {
                myInprogressResponseModel.append(post)
            }
        }
    }
    
    // MARK: - Methods
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
            return myInprogressResponseModel[row].postId
        } else if section == 4 {
            return myExpiredResponseModel[row].postId
        } else {
            return myDonateResponseModel[row].postId
        }
    }
}
