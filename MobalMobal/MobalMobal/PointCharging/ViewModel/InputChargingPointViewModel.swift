//
//  InputChargingPointViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/08.
//

import Alamofire
import Foundation

class InputChargingPointViewModel {
    var model: ChargingData?
    var amount: Int?
    var userName: String?
    var chargedAt: String?
    func postCharging(completion: @escaping (Result<Void, DoneError>) -> Void) {
        guard let amount = amount,
              let userName = userName,
              let chargedAt = chargedAt else { return }

        DoneProvider.charge(amount: amount, userName: userName, chargedAt: chargedAt) { [weak self] response in
            switch response.code {
            case 200:
                self?.model = response.data
                completion(.success(()))
            case 400: //인자값이 부정확한 경우
                completion(.failure(.noData))
            default:
                completion(.failure(.client))
            }
        } failure: { (err) in
            print(err.localizedDescription)
            completion(.failure((.unknown)))
        }
    }
}
