//
//  DonationDetailViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/01.
//
import Kingfisher
import UIKit

class DonationDetailViewController: UIViewController {
    // MARK: - UI Components
    // Top Image Area
    lazy var detailImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor = .purpleishBlue // TODO: backgroundColor 대신 로딩 이미지
        return imageView
    }()
    
    let translucentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black70
        return view
    }()
    
    let progressLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "0%" // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "Futura-Bold", size: 18)
        label.textColor = .white
        return label
    }()
    
    let progressBarView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .wheat
        // shadow 적용
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.red.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 10 / UIScreen.main.scale
        return view
    }()
    
    let dDayLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "D-∞" // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "Futura-Regular", size: 13)
        label.textColor = .veryLightPink
        return label
    }()
    
    // Mid Description Area
    let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor = .wheat // TODO: 스켈레톤 데이터
        imageView.layer.cornerRadius = 29
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Someone" // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "Futura-Medium", size: 16)
        label.textColor = .white
        return label
    }()
    
    let zosaLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "는" // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .white
        return label
    }()
    
    let giftLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "PS5" // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "Futura-Medium", size: 16)
        label.textColor = .wheat
        // shadow 적용
        label.layer.masksToBounds = false
        label.layer.shadowColor = UIColor.red.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 10)
        label.layer.shadowRadius = 10 / UIScreen.main.scale
        return label
    }()
    
    let wantLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "가지고 싶어요" // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .white
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = """
            Lorem Ipsum is simply dummy text of the printing and typesetting industry.
            Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
            """  // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    // Bottom Detail Info Area
    let destinationTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "목표 금액"
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 15)
        label.textColor = .veryLightPink
        return label
    }()
    
    let destinationNumberLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "2,000,000" // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 16)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        return label
    }()
    
    let fundAmountTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "모금 금액"
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 15)
        label.textColor = .veryLightPink
        return label
    }()
    
    let fundAmountNumberLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "153,000" // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 16)
        label.textColor = .lightBluishGreen
        return label
    }()
    
    let participantsTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "참여자"
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 15)
        label.textColor = .veryLightPink
        return label
    }()
    
    let participantsCountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "(31)" // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 15)
        label.textColor = .veryLightPink
        return label
    }()
    
    let endDateTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "종료날짜"
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 15)
        label.textColor = .veryLightPink
        return label
    }()
    
    let endDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "2021.03.01" // TODO: 스켈레톤 데이터
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 16)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        return label
    }()
    
    let donationButton: UIView = {
        let button: UIButton = UIButton()
        button.backgroundColor = .purpleishBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Someone 에게 후원하기", for: .normal)
        button.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 16)
        return button
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    // MARK: - Actions
    // MARK: - Methods
    // MARK: - Protocols
}
