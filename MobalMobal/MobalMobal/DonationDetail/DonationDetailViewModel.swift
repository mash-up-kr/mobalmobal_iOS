//
//  DonationDetailViewModel.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/07.
//
import Alamofire
import Foundation

class DonationDetailViewModel {
    private var donationId: Int = 1 {
        didSet { getDonationInfo() }
    }
    
    func setDonationId(_ donationId: Int) {
        self.donationId = donationId
    }
    
    // MARK: - API
    func getDonationInfo() {
        let url: String = "\(ServerURL.detailURL)/\(donationId)"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let data):
                print("🐻 Detail Response: \(data)")
            case .failure(let error):
                print("🐻 Detail API Error: \(error)")
            }
        }
    }
}
