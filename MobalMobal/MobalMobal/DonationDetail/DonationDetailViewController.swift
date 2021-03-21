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
    let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .backgroundColor
        return scrollView
    }()
    
    let contentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    // Top Image Area
    lazy var detailImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "doneImage") // 스켈레톤 데이터
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let translucentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black70
        return view
    }()
    
    let progressLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "0%" // 스켈레톤 데이터
        label.font = UIFont(name: "Lato-Bold", size: 18)
        label.textColor = .white
        return label
    }()
    
    let progressBarView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .wheat
        // shadow 적용
        view.layer.shadowColor = UIColor.yellowTan80.cgColor
        view.layer.shadowRadius = 10 / UIScreen.main.scale
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = .zero
        view.layer.masksToBounds = false
        return view
    }()
    
    let dDayLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "D-10" // 스켈레톤 데이터
        label.font = UIFont(name: "Lato-Regular", size: 13)
        label.textColor = .veryLightPink
        return label
    }()
    
    // Mid Description Area
    let nameGiftGroupView: UIView = UIView()
    
    let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "profile") // 스켈레톤 데이터
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 29
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Someone" // 스켈레톤 데이터
        label.font = .futra(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    let zosaLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "는" // 스켈레톤 데이터
        label.font = .spoqaHanSansNeo(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let giftLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "PS5" // 스켈레톤 데이터
        label.font = .futra(ofSize: 16, weight: .medium)
        label.textColor = .wheat
        // shadow 적용
        label.layer.shadowColor = UIColor.yellowTan80.cgColor
        label.layer.shadowRadius = 10 / UIScreen.main.scale
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = .zero
        label.layer.masksToBounds = false
        return label
    }()
    
    let wantLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "가지고 싶어요" // 스켈레톤 데이터
        label.font = .spoqaHanSansNeo(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = """
            Lorem Ipsum is simply dummy text of the printing and typesetting industry.
            Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
            """  // 스켈레톤 데이터
        label.font = .spoqaHanSansNeo(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    // Bottom Detail Info Area
    let detailGroupView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .blackTwo
        return view
    }()
    
    let destinationTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "목표 금액"
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
        label.textColor = .veryLightPink
        return label
    }()
    
    let destinationNumberLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "2,000,000" // 스켈레톤 데이터
        label.font = UIFont(name: "Lato-Bold", size: 16)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        return label
    }()
    
    let fundAmountTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "모금 금액"
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
        label.textColor = .veryLightPink
        return label
    }()
    
    let fundAmountNumberLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "153,000" // 스켈레톤 데이터
        label.font = UIFont(name: "Lato-Bold", size: 16)
        label.textColor = .lightBluishGreen
        return label
    }()
    
    let participantsTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "참여자"
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
        label.textColor = .veryLightPink
        return label
    }()
    
    let participantsCountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "(31)" // 스켈레톤 데이터
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
        label.textColor = .veryLightPink
        return label
    }()
    
    let participantsProfilesView: DetailParticipantsView = {
        let view: DetailParticipantsView = DetailParticipantsView()
        return view
    }()
    
    let endDateTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "종료날짜"
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
        label.textColor = .veryLightPink
        return label
    }()
    
    let endDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "2021.03.01" // 스켈레톤 데이터
        label.font = UIFont(name: "Lato-Bold", size: 16)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        return label
    }()
    
    let donationButton: UIView = {
        let button: UIButton = UIButton()
        button.backgroundColor = .purpleishBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Someone 에게 후원하기", for: .normal)
        button.titleLabel?.font = .spoqaHanSansNeo(ofSize: 16, weight: .medium)
        return button
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        setActions()
    }
    
    override func updateViewConstraints() {
        setScrollViewConstraints()
        setTopImageAreaConstraints()
        setMidDescriptionAreaConstraints()
        setBottomDetailInfoAreaConstraints()
        
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    @IBAction private func clickParticipantsMoreButton() {
        // 참여자 더보기 버튼 클릭 시
        print("🐻 참여자 더보기 🐻")
    }
    
    @IBAction private func clickDonationButton() {
        // 후원하기 버튼 클릭 시
        print("🐻 후원하기 🐻")
        let inputDonationMoneyVC: InputDonationMoneyViewController = InputDonationMoneyViewController()
        let navigation: UINavigationController = UINavigationController(rootViewController: inputDonationMoneyVC)
        navigation.modalPresentationStyle = .overFullScreen
        present(navigation, animated: true, completion: nil)
    }
    
    // MARK: - Methods
    private func setActions() {
        let moreButtonTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickParticipantsMoreButton))
        participantsProfilesView.moreButtonView.addGestureRecognizer(moreButtonTap)
        
        let donationButtonTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickDonationButton))
        donationButton.addGestureRecognizer(donationButtonTap)
    }
    
    // MARK: - Protocols
}
