//
//  CreateDonationViewModel.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/05/04.
//

import UIKit

protocol CreateDonationViewModelDeleagate: class {
    func unavaliableToken()
    func success()
}

class CreateDonationViewModel {
    
    // MARK: - Property
    var donation: CreateDonation = CreateDonation(title: "", description: nil, postImage: "", goal: "0", startedAt: "", endAt: "")
    weak var delegate: CreateDonationViewModelDeleagate?
    
    // MARK: - Method
    func createDonation(donation: CreateDonation) {
        DoneProvider.createDonation(donation: donation) { [weak self] response in
            guard let self = self else {
                return
            }
            
            if response.code == 200 {
                self.delegate?.success()
            } else if response.code == 400 || response.code == 401 {
                self.delegate?.unavaliableToken()
            }
        } failure: { (error) in
            print("CreateDonation : \(error.localizedDescription)")
            return
        }
    }
    
    func textFieldisFilled(textField: UITextField) -> Bool {
        return !(textField.text!.isEmpty)
    }
}
