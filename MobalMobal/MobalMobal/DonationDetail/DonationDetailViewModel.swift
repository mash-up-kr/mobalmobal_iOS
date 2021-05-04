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
    func didProfileImageChanged(to url: String?)
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
    private var detailResponse: DonationDetailData? { // 응답이 들어오면 값 세팅
        didSet { setDonationInfo() }
    }
    private lazy var donationImageURL: String? = nil { // 이미지
        didSet { delegate?.didImageChanged(to: donationImageURL) }
    }
    private lazy var profileImageURL: String? = nil {
        didSet { delegate?.didProfileImageChanged(to: profileImageURL) }
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
        guard let info = detailResponse?.post else { return }
        
        self.donationImageURL = info.postImage
        self.profileImageURL = info.user.profileImageURL
        self.donationPublisherName = info.user.nickname
        self.donationTitle = info.title
        self.donationDescription = info.description ?? ""
        self.donationGoal = info.goal
        self.donationAmount = info.current
        self.donationEndDate = info.endDate
    }
    
    // MARK: - Get Method
    func getDonationId() -> Int {
        self.donationId
    }
    func getNickname() -> String {
        self.donationPublisherName
    }
    func getGiftName() -> String {
        self.donationTitle
    }
    
    // MARK: - API Method
    func callDonationInfoAPI() {
        DoneProvider.getDonationDetail(postId: donationId) { [weak self] response in
            self?.detailResponse = response.data
        } failure: { _ in
            return
        }
    }
}
