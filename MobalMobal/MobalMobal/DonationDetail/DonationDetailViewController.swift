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
        scrollView.alwaysBounceVertical = true
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
        label.text = "D-Day" // 스켈레톤 데이터
        label.font = UIFont(name: "Lato-Regular", size: 13)
        label.textColor = .veryLightPink
        return label
    }()
    
    // Mid Description Area
    let nameGiftGroupView: UIView = UIView()
    let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "Profile") // 스켈레톤 데이터
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 29
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "User" // 스켈레톤 데이터
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
        label.text = "선물" // 스켈레톤 데이터
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
        label.text = ""  // 스켈레톤 데이터
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
        label.text = "0" // 스켈레톤 데이터
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
        label.text = "0" // 스켈레톤 데이터
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
        label.text = "" // 스켈레톤 데이터
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
        label.textColor = .veryLightPink
        return label
    }()
    lazy var participantsProfilesView: DetailParticipantsView = {
        let view: DetailParticipantsView = DetailParticipantsView()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickParticipantsMoreButton))
        view.moreButtonView.addGestureRecognizer(tap)
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
        label.text = "20xx.xx.xx" // 스켈레톤 데이터
        label.font = UIFont(name: "Lato-Bold", size: 16)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        return label
    }()
    lazy var donationButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .purpleishBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("User 에게 후원하기", for: .normal)
        button.titleLabel?.font = .spoqaHanSansNeo(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(clickDonationButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private lazy var viewModel: DonationDetailViewModel = DonationDetailViewModel(delegate: self)
    
    // MARK: - Initializer
    init(donationId: Int) {
        super.init(nibName: nil, bundle: nil)
        viewModel.setDonationId(donationId)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
    }
    override func updateViewConstraints() {
        setScrollViewConstraints()
        setTopImageAreaConstraints()
        setMidDescriptionAreaConstraints()
        setBottomDetailInfoAreaConstraints()
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    @objc
    private func clickParticipantsMoreButton() {
        showParticipantsAlert()
    }
    @objc
    private func clickDonationButton() {
        presentDonateMoneyVC()
    }
    
    // MARK: - Methods
    private func showParticipantsAlert() {
        let alert: UIAlertController = UIAlertController(title: "준비중입니다.", message: "빠른 시일 내로 참여자 확인이 가능하도록 하겠습니다.", preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    private func presentDonateMoneyVC() {
        let donateMoneyVC: DonateMoneyViewController = DonateMoneyViewController()
        let navigationController: UINavigationController = UINavigationController(rootViewController: donateMoneyVC)
        navigationController.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true)
    }
}

// MARK: - DonationDetailViewModelDelegate
extension DonationDetailViewController: DonationDetailViewModelDelegate {
    func didImageChanged(to url: String?) {
        guard let url = url else {
            detailImageView.image = UIImage(named: "doneImage")
            return
        }
        detailImageView.kf.setImage(with: URL(string: url))
    }
    func didPublisherChanged(to nickname: String) {
        nameLabel.text = nickname
        donationButton.setTitle("\(nickname)에게 후원하기", for: .normal)
    }
    func didTitleChanged(to title: String) {
        giftLabel.text = title
    }
    func didDesciptionChanged(to description: String) {
        descriptionLabel.text = description
    }
    func didProgressChanged(current: Int, goal: Int) {
        let progress: Float = Float(current) / Float(goal)
        progressLabel.text = "\(Int(progress) * 100)%"
        destinationNumberLabel.text = goal.changeToCommaFormat()
        fundAmountNumberLabel.text = current.changeToCommaFormat()
        progressBarView.snp.updateConstraints { make in
            make.width.equalToSuperview().multipliedBy(progress)
        }
    }
    func didEndDateChanged(to date: Date?) {
        guard let date = date else { return }
        
        // 종료 날짜
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        endDateLabel.text = dateFormatter.string(from: date)
        
        // D-Day
        let dueDay: Int = Date().getDueDay(of: date)
        if dueDay > 0 {
            dDayLabel.text = "D-\(dueDay)"
        } else if dueDay == 0 {
            dDayLabel.text = "D-Day"
        } else {
            dDayLabel.text = "D+\(-dueDay)"
        }
    }
}
