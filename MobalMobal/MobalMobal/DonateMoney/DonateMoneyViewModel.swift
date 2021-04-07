//
//  DonateMoneyViewModel.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/08.
//
import Alamofire
import Foundation

protocol DonateMoneyViewModelDelegate: AnyObject {
    func failDonateMoney(message: String?)
    func completeDonateMoney(amount: Int)
}

class DonateMoneyViewModel {
    weak var delegate: DonateMoneyViewModelDelegate?
    
    // MARK: - Properties
    let amounts: [Int] = [1_000, 2_000, 5_000, 10_000, 50_000, 100_000]
    
    private var postId: Int = -1
    private var amount: Int?
    private var donateResponse: DonateMoneyResponse? {  // 응답 받아오면 delegate 함수 호출
        didSet {
            if donateResponse?.code == .success, let amount: Int = amount {
                delegate?.completeDonateMoney(amount: amount)
            } else {
                delegate?.failDonateMoney(message: donateResponse?.message)
            }
        }
    }
    
    // MARK: - Initializer
    init(delegate: DonateMoneyViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - getter, setter
    func setPostId(_ postId: Int) {
        self.postId = postId
    }
    func getPostId() -> Int {
        self.postId
    }
    
    // MARK: - API
    func donate(amount: Int) {
        let donateURL: String = ServerURL.donateURL
        // TODO : testToken -> UserDefaults Token
        let header: HTTPHeaders = ["authorization": ServerString.testToken]
        let params: Parameters = ["post_id": postId, "amount": amount]
        self.amount = amount
        
        AF.request(donateURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                print("🐻 Donate Response: \(value)")
                self?.donateResponse = try? self?.parse(donate: value)
            case .failure(let error):
                print("🐻 Donate API Error: \(error)")
            }
        }
    }
    
    func parse(donate value: Any) throws -> DonateMoneyResponse {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
            let parsedResponse: DonateMoneyResponse = try JSONDecoder().decode(DonateMoneyResponse.self, from: data)
            print("🐻 Donate Parsed Data: \(parsedResponse)")
            return parsedResponse
        } catch let error {
            print("🐻 Donate Response Decode Error: \(error.localizedDescription)")
            throw error
        }
    }
}
