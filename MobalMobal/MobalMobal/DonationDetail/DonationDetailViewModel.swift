//
//  DonationDetailViewModel.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/07.
//
import Alamofire
import Foundation

class DonationDetailViewModel {
    private var detailResponse: DonationDetailResponse?
    
    private var donationId: Int = 1 {
        didSet { getDonationInfo() }
    }
    
    func setDonationId(_ donationId: Int) {
        self.donationId = donationId
    }
    
    // MARK: - API
    func getDonationInfo() {
        let url: String = "\(ServerURL.detailURL)/\(donationId)"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let data):
                print("🐻 Detail Response: \(data)")
                self?.detailResponse = try? self?.parse(response: data)
            case .failure(let error):
                print("🐻 Detail API Error: \(error)")
            }
        }
    }
    
    private func parse(response value: Any) throws -> DonationDetailResponse {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
            let parsedResponse: DonationDetailResponse = try JSONDecoder().decode(DonationDetailResponse.self, from: data)
            print("🐻 Detail Parsed Data: \(parsedResponse)")
            return parsedResponse
        } catch let error {
            print("🐻 Detail Response Decode Error: \(error.localizedDescription)")
            throw error
        }
    }
}
