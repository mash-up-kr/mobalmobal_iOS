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
    
    static func donate(_ amount: Int, to postId: Int, success: @escaping (ParseResponse<DonateMoneyData>) -> Void, failure: @escaping (Error) -> Void) {
        NetworkProvider.request(.donate(post: postId, money: amount), to: DonateMoneyData.self, success: success, failure: failure)
    }
}
