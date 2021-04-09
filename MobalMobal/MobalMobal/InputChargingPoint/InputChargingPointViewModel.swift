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
    func postCharging() {
        print("🍎🍎post charging🍎🍎")
        DoneProvider.charge(amount: 1000, userName: "ee", chargedAt: "2021-04-09T12:26:35.793Z") { [weak self] response in
            self?.model = response.data
        } failure: { (err) in
            print(err.localizedDescription)
        }
    }
}
