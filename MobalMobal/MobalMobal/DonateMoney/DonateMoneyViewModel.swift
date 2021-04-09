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
    private var donateData: DonateMoneyData? {
        didSet { donateDataChanged() }
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
        self.amount = amount
        DoneProvider.donate(amount, to: postId) { [weak self] response in
            self?.donateData = response.data
            if let message = response.message {
                self?.delegate?.failDonateMoney(message: message)
            }
        } failure: { error in
            self.delegate?.failDonateMoney(message: error.localizedDescription)
        }
    }
    
    private func donateDataChanged() {
        if let amount = self.donateData?.donate?.amount {
            delegate?.completeDonateMoney(amount: amount)
        }
    }
}
