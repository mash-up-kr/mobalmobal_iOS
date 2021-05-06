//
//  ProfileViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/02.
//

import Alamofire
import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func setNavigationTitle(_ nickName: String?)
    func networkError()
    func tokenError()
    func completeAPICall()
}

class ProfileViewModel {
    // MARK: - Properties
    var profileResponseModel: ProfileData?
    var myInprogressResponseModel: [MydonationPost] = []
    var myExpiredResponseModel: [MydonationPost]?
    var myDonateResponseModel: [Donate] = [Donate]()
    weak var delegate: ProfileViewModelDelegate?
    
    // MARK: - API call
    private func callMyProfileAPI(_ completion: @escaping () -> Void = {} ) {
        DoneProvider.getUserProfile() { [weak self] response in
            switch response.code {
            case 200:
                self?.profileResponseModel = response.data
                self?.delegate?.setNavigationTitle(self?.getUserNickname())
                return completion()
            default:
                self?.delegate?.networkError()
            }
        } failure: { [weak self] err in
            print(err.localizedDescription)
            self?.delegate?.tokenError()
        }
    }
    
    private func callMyInProgressAPI(_ completion: @escaping () -> Void = {}) {
        DoneProvider.getMyDonation(status: "IN_PROGRESS") { [weak self] response in
            switch response.code {
            case 200:
                guard let posts = response.data?.posts else { return }
                self?.myInprogressResponseModel += posts
                return completion()
            default:
                self?.delegate?.networkError()
            }
        } failure: { [weak self] err in
            print(err.localizedDescription)
            self?.delegate?.tokenError()
        }
    }
    
    private func callMyBeforeAPI(_ completion: @escaping () -> Void = {}) {
        DoneProvider.getMyDonation(status: "BEFORE") { [weak self] response in
            switch response.code {
            case 200:
                guard let posts = response.data?.posts else { return }
                self?.myInprogressResponseModel += posts
                return completion()
            default:
                self?.delegate?.networkError()
            }
        } failure: { [weak self] err in
            print(err.localizedDescription)
            self?.delegate?.tokenError()
        }
    }
    
    private func callMyExpiredAPI(_ completion: @escaping () -> Void = {}) {
        DoneProvider.getMyDonation(status: "EXPIRED") { [weak self] response in
            switch response.code {
            case 200:
                self?.myExpiredResponseModel = response.data?.posts
                return completion()
            default:
                self?.delegate?.networkError()
            }
        } failure: { [weak self] err in
            print(err.localizedDescription)
            self?.delegate?.tokenError()
        }
    }
    
    private func callMyDonateAPI(_ completion: @escaping () -> Void = {}) {
        DoneProvider.getMyDonate { [weak self] response in
            switch response.code {
            case 200:
                self?.myDonateResponseDuplicateCheck(response)
                return completion()
            default:
                self?.delegate?.networkError()
            }
        } failure: { [weak self] err in
            print(err.localizedDescription)
            self?.delegate?.tokenError()
        }
    }
    
    func callAPI(_ endRefreshing: @escaping () -> Void = {} ) {
        var complete: Int = 0
        myInprogressResponseModel = []
        callMyProfileAPI { [weak self] in
            complete += 1
            if complete == 5 {
                self?.delegate?.completeAPICall()
                endRefreshing()
            }
        }
        callMyBeforeAPI { [weak self] in
            complete += 1
            if complete == 5 {
                self?.delegate?.completeAPICall()
                endRefreshing()
            }
        }
        callMyInProgressAPI { [weak self] in
            complete += 1
            if complete == 5 {
                self?.delegate?.completeAPICall()
                endRefreshing()
            }
        }
        callMyDonateAPI { [weak self] in
            complete += 1
            if complete == 5 {
                self?.delegate?.completeAPICall()
                endRefreshing()
            }
        }
        callMyExpiredAPI { [weak self] in
            complete += 1
            if complete == 5 {
                self?.delegate?.completeAPICall()
                endRefreshing()
            }
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
            return myInprogressResponseModel[row].postId
        } else if section == 4 {
            return myExpiredResponseModel?[row].postId
        } else {
            return myDonateResponseModel[row].postId
        }
    }
}
