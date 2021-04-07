//
//  DonationDetailViewModel.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/07.
//
import Alamofire
import Foundation

protocol DonationDetailViewModelDelegate: class {
    func didImageChanged(to url: String?)
    func didPublisherChanged(to nickname: String)
    func didTitleChanged(to title: String)
    func didDesciptionChanged(to description: String)
    func didProgressChanged(current: Int, goal: Int)
    func didEndDateChanged(to date: Date?)
}

class DonationDetailViewModel {
    weak var delegate: DonationDetailViewModelDelegate?
    
    // MARK: - Properties
    private var donationId: Int = -1 { // id가 정해지면 API 통신
        didSet { callDonationInfoAPI() }
    }
    private var detailResponse: DonationDetailResponse? { // 응답이 들어오면 값 세팅
        didSet { setDonationInfo() }
    }
    private lazy var donationImageURL: String? = nil { // 이미지
        didSet { delegate?.didImageChanged(to: donationImageURL) }
    }
    private lazy var donationPublisherName: String = "누군가" {
        didSet { delegate?.didPublisherChanged(to: donationPublisherName) }
    }
    private lazy var donationTitle: String = "선물" {
        didSet { delegate?.didTitleChanged(to: donationTitle) }
    }
    private lazy var donationDescription: String = "한마디" {
        didSet { delegate?.didDesciptionChanged(to: donationDescription) }
    }
    private lazy var donationGoal: Int = 0 { // 목표액
        didSet { delegate?.didProgressChanged(current: donationAmount, goal: donationGoal) }
    }
    private lazy var donationAmount: Int = 0 {   // 모금액
        didSet { delegate?.didProgressChanged(current: donationAmount, goal: donationGoal) }
    }
    private lazy var donationEndDate: Date? = nil {  // 종료 날짜
        didSet { delegate?.didEndDateChanged(to: donationEndDate) }
    }
    
    // MARK: - Initializer
    init(delegate: DonationDetailViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    // MARK: - Set Method
    func setDonationId(_ donationId: Int) {
        self.donationId = donationId
    }
    
    private func setDonationInfo() {
        guard let info = detailResponse?.data?.post else { return }
        
        self.donationImageURL = info.postImage
        self.donationPublisherName = "\(info.userId)번 사용자" // 유저 id가 아닌 닉네임 가져와야 함!
        self.donationTitle = info.title
        self.donationDescription = info.description ?? ""
        self.donationGoal = info.goal
        self.donationAmount = info.current
        self.donationEndDate = info.endDate
    }
    
    // MARK: - API Method
    func callDonationInfoAPI() {
        let url: String = "\(ServerURL.detailURL)/\(donationId)"

        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let data):
                print("🐻 Detail Response: \(data)")
                self?.detailResponse = try? self?.parse(detail: data)
            case .failure(let error):
                print("🐻 Detail API Error: \(error)")
            }
        }
    }
    
    private func parse(detail value: Any) throws -> DonationDetailResponse {
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
            let decoder: JSONDecoder = JSONDecoder()
            decoder.dateDecodingStrategy = try .iso8610WithZ()
            
            let parsedResponse: DonationDetailResponse = try decoder.decode(DonationDetailResponse.self, from: data)
            print("🐻 Detail Parsed Data: \(parsedResponse)")
            return parsedResponse
        } catch let error {
            print("🐻 Detail Response Decode Error: \(error)")
            throw error
        }
    }
}
