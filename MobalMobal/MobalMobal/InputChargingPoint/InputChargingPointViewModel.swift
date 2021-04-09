//
//  InputChargingPointViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/08.
//

import Alamofire
import Foundation

class InputChargingPointViewModel {
    var model: ChargingData? {
        didSet {
            print("🍎🍎response set!!!!🍎🍎")
        }
    }
    var amount: Int?
    var userName: String?
    var chargedAt: String?
    func postCharging() {
        print("🍎🍎post charging🍎🍎")
        guard let amount = amount,
              let userName = userName,
              let chargedAt = chargedAt else { return }
        DoneProvider.charge(amount: amount, userName: userName, chargedAt: chargedAt) { [weak self] response in
            self?.model = response.data
        } failure: { (err) in
            print(err.localizedDescription)
        }
    }
}
