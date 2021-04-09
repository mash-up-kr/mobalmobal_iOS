//
//  DoneProvider.swift
//  MobalMobal
//
//  Created by 이재성 on 2021/04/09.
//

import Foundation

enum DoneProvider {
    static func getMain(item: Int, limit: Int, success: @escaping (ParseResponse<MainResponse>) -> Void, failure: @escaping (Error) -> Void) {
        NetworkProvider.request(.getMain(item: item, limit: limit), to: MainResponse.self, success: success, failure: failure)
    }
    
    static func getDonationDetail(postId: Int, success: @escaping (ParseResponse<DonationDetailData>) -> Void, failure: @escaping (Error) -> Void) {
        NetworkProvider.request(.getDetail(posts: postId), to: DonationDetailData.self, success: success, failure: failure)
    }
    static func getUserProfile(success: @escaping (ParseResponse<ProfileData>) -> Void, failure: @escaping (Error) -> Void) {
        NetworkProvider.request(.getUserProfile, to: ProfileData.self, success: success, failure: failure)
    }
    static func getMyDonation(success: @escaping (ParseResponse<MydonationData>) -> Void, failure: @escaping (Error) -> Void) {
        NetworkProvider.request(.getMyDonation, to: MydonationData.self, success: success, failure: failure)
    }
    static func getMyDonate(success: @escaping (ParseResponse<MyDonates>) -> Void, failure: @escaping (Error) -> Void) {
        NetworkProvider.request(.getMyDonate, to: MyDonates.self, success: success, failure: failure)
    }
}
