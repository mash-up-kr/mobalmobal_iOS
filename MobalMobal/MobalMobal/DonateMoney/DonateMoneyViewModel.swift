//
//  DonateMoneyViewModel.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/08.
//
import Alamofire
import Foundation

protocol DonateMoneyViewModelDelegate: AnyObject {
    func insufficientPoint()
    func failDonateMoney(message: String?)
    func completeDonateMoney(amount: Int)
}

class DonateMoneyViewModel {
    weak var delegate: DonateMoneyViewModelDelegate?
    
    // MARK: - Properties
    let amounts: [Int] = [1_000, 2_000, 5_000, 10_000, 50_000, 100_000]
    
    private var postId: Int = -1
    private var nickname: String = ""
    private var giftName: String = ""
    private var amount: Int?
    private var donateData: DonateMoneyData? {
        didSet { donateDataChanged() }
    }
    
    // MARK: - Initializer
    init(delegate: DonateMoneyViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - getter, setter
    func getPostId() -> Int {
        self.postId
    }
    func setPostId(_ postId: Int) {
        self.postId = postId
    }
    func getNickname() -> String {
        self.nickname
    }
    func setNickname(_ nickname: String) {
        self.nickname = nickname
    }
    func getGiftName() -> String {
        self.giftName
    }
    func setGiftName(_ giftName: String) {
        self.giftName = giftName
    }
    
    // MARK: - API
    func checkChargedPoint() -> Int {
        var chargedCash = 0
        DoneProvider.getUserProfile { response in
            if let cash = response.data?.user.cash {
                chargedCash = cash
            }
        } failure: { _ in }
        return chargedCash
    }
    
    func donate(amount: Int) {
        self.amount = amount
        
        // 잔액 부족
        if checkChargedPoint() < amount {
            delegate?.insufficientPoint()
            return
        }
        // 정상 작동
        DoneProvider.donate(amount, to: postId) { [weak self] response in
            self?.donateData = response.data
            if let message = response.message {
                self?.delegate?.failDonateMoney(message: message)
                UserInfo.shared.needToUpdate = true
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
