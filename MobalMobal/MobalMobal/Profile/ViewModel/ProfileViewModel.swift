//
//  ProfileViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/02.
//

import Alamofire
import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func tableViewUpdate(section: IndexSet)
}
class ProfileViewModel {
    // MARK: - Properties
    weak var mainDelegate: ProfileViewModelDelegate?
    var profileResponseModel: ProfileData? {
        didSet {
            let sectionRange: IndexSet = IndexSet(0...0)
            mainDelegate?.tableViewUpdate(section: sectionRange)
        }
    }
    // 내가 열은 도네 (종료 & 내연도네)
    var mydonationResponseModel: MydonationData? {
        didSet {
            let sectionRange: IndexSet = IndexSet(1...4)
            mainDelegate?.tableViewUpdate(section: sectionRange)
        }
    }
    // 내가 후원한 도네
    var myDonateResponseModel: [Donate] = [Donate]()
    
    // MARK: - Methods
    func getProfileResponse() {
        DoneProvider.getUserProfile() { [weak self] response in
            self?.profileResponseModel = response.data
        } failure: { err in
            print(err.localizedDescription)
        }
    }
    func getMydontaionResponse() {
        DoneProvider.getMyDonation { [weak self] response in
            self?.mydonationResponseModel = response.data
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
        let sectionRange: IndexSet = IndexSet(1...4)
        self.mainDelegate?.tableViewUpdate(section: sectionRange)
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
        // 날자가 지났으면 true반환 -> 종료된도네에 넣는다.
        Date().getDueDay(of: date) < 0 ? true : false
    }
    func getMyDonate() -> [Donate]? {
        myDonateResponseModel
    }
    func getPostId(section: Int, row: Int) -> Int? {
        if section == 2 || section == 4 {
            return mydonationResponseModel?.posts[row].postId
        }else {
            return myDonateResponseModel[row].postId
        }
    }
}
