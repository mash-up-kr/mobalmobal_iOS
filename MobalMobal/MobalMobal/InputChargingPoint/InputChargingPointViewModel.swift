//
//  InputChargingPointViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/08.
//

import Alamofire
import Foundation

class InputChargingPointViewModel {
    let tokenID: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJpYXQiOjE2MTc3ODIzNzgsImV4cCI6MTY0OTMzOTk3OCwiaXNzIjoiaHllb25pIn0.EylJ0O9zsOePeB6WmQ5-Xfm6X63L29s6iUxZL6dxzdA"
    private lazy var headers: HTTPHeaders = ["authorization": tokenID]
    private lazy var body: [String: Any] = [
        "amount": 20000,
        "user_name": "민경빈",
        "charged_at": "2021-04-03T15:52:51.983Z"
    ]
    var model: InputChargingPointResponse? {
        didSet {
            print("response set!!!!")
        }
    }
    func postCharging() {
        AF.request("http://13.125.168.51:3000/charge", method: .post, parameters: body, headers: headers).responseJSON { response in
            print("alamofire")
            switch response.result {
            case .success(let value):
                do {
                    let data: Data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let chargingResponse: InputChargingPointResponse? = try JSONDecoder().decode(InputChargingPointResponse.self, from: data)
                    
                    if chargingResponse?.code == 200 {
                        self.model = chargingResponse
                    } else{
                        print("code err")
                        return
                    }
                } catch (let error) {
                    print(error.localizedDescription, "1")
                }
            case .failure(let err):
                print(err.localizedDescription, "2")
            }
            
        }
    }
}
