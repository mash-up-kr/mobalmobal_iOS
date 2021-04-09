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
    
    static func charge(amount: Int, userName: String, chargedAt: String, success: @escaping (ParseResponse<ChargingData>) -> Void, failure: @escaping (Error) -> Void) {
        NetworkProvider.request(.charge(amount: amount, userName: userName, chargedAt: chargedAt), to: ChargingData.self, success: success, failure: failure)
    }
}
