//
//  MyAccountViewModel.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/06/07.
//

import UIKit

protocol MyAccountViewModelDeleagte: NSObject {
    func networkErr()
}

class MyAccountViewModel {
    
    // MARK: - Properties
    var model: ProfileData?
    var bankName: String?
    var accountName: String?
    weak var delegate: MyAccountViewModelDeleagte?
    var getBankName: String? {
        model?.user.bankName
    }
    var getAccountName: String? {
        model?.user.accountNumber
    }
    
    // MARK: -API call
    func patchMyAccount() {
        DoneProvider.myAccount(bankName: bankName, accountNumber: accountName) { [weak self] response in
            self?.model = response.data
        } failure: { [weak self] err in
            print("path my account error: ", err.localizedDescription)
            self?.delegate?.networkErr()
        }
        
    }
    func getMyProfile(_ completion: @escaping (Bool) -> Void) {
        DoneProvider.getUserProfile() { [weak self] response in
            if let _ = response.data?.user.accountNumber,
               let _ = response.data?.user.bankName {
                self?.model = response.data
                return completion(true)
            }
        } failure: { [weak self] err in
            print("get my profile error: ",err.localizedDescription)
            self?.delegate?.networkErr()
        }
    }

}
