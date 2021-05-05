//
//  DonationDetailViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/01.
//
import Kingfisher
import UIKit
import SnapKit

class DonationDetailViewController: DoneBaseViewController {
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
    let detailImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: "doneImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let translucentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black40
        return view
    }()
    let progressLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "0%"
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    let progressBarView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .wheat
        view.drawShadow(color: .yellowTan80, blur: 10)
        view.layer.masksToBounds = false
        return view
    }()
    let dDayLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "D-알수없음"
        label.font = .spoqaHanSansNeo(ofSize: 13, weight: .regular)
        label.textColor = .veryLightPink
        return label
    }()
    
    // Mid Description Area
    let nameGiftGroupView: UIView = UIView()
    lazy var profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: placeholderImage)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 29
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.text = "누군가"
        label.font = .spoqaHanSansNeo(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()
    let wantLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .left
        label.text = "가 원하는"
        label.font = .spoqaHanSansNeo(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    let giftLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.text = "선물"
        label.font = .spoqaHanSansNeo(ofSize: 16, weight: .medium)
        label.textColor = .wheat
        label.drawShadow(color: .yellowTan80, blur: 10)
        label.layer.masksToBounds = false
        return label
    }()
    let descriptionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .left
        label.text = "한마디"
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
        label.textAlignment = .left
        label.text = "목표 금액"
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
        label.textColor = .veryLightPink
        return label
    }()
    let destinationNumberLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .left
        label.text = "0"
        label.font = .spoqaHanSansNeo(ofSize: 16, weight: .bold)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        return label
    }()
    let fundAmountTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .left
        label.text = "모금 금액"
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
        label.textColor = .veryLightPink
        return label
    }()
    let fundAmountNumberLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .left
        label.text = "0"
        label.font = .spoqaHanSansNeo(ofSize: 16, weight: .bold)
        label.textColor = .lightBluishGreen
        return label
    }()
//    let participantsTitleLabel: UILabel = {
//        let label: UILabel = UILabel()
//        label.textAlignment = .left
//        label.text = "참여자"
//        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
//        label.textColor = .veryLightPink
//        return label
//    }()
//    let participantsCountLabel: UILabel = {
//        let label: UILabel = UILabel()
    //        label.textAlignment = .left
//        label.text = ""
//        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
//        label.textColor = .veryLightPink
//        return label
//    }()
//    lazy var participantsProfilesView: DetailParticipantsView = {
//        let view: DetailParticipantsView = DetailParticipantsView()
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickParticipantsMoreButton))
//        view.moreButtonView.addGestureRecognizer(tap)
//        return view
//    }()
    let endDateTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "종료날짜"
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .medium)
        label.textColor = .veryLightPink
        return label
    }()
    let endDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "YYYY.MM.dd"
        label.font = .spoqaHanSansNeo(ofSize: 16, weight: .bold)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        return label
    }()
    let donationButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .purpleishBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("누군가 에게 후원하기", for: .normal)
        button.titleLabel?.font = .spoqaHanSansNeo(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(clickDonationButton), for: .touchUpInside)
        return button
    }()
    var isUpdateConstraints: Bool = false
    var progress: Float = 0
    
    // MARK: - Properties
    private lazy var viewModel: DonationDetailViewModel = DonationDetailViewModel(delegate: self)
    let placeholderImage: UIImage? = UIImage(named: "profile_default")!
    
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
        setNavigationItems(title: "", backButtonImageName: "arrowChevronBigLeft", action: #selector(clickBackButton))
        view.setNeedsUpdateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func updateViewConstraints() {
        if !isUpdateConstraints {
            setScrollViewConstraints()
            setTopImageAreaConstraints()
            setMidDescriptionAreaConstraints()
            setBottomDetailInfoAreaConstraints()
        }
        remakeProgressBarViewConstraints()
        
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    @objc
    private func clickParticipantsMoreButton() {
        showParticipantsAlert()
    }
    
    @objc
    private func clickDonationButton() {
        if KeychainManager.isEmptyUserToken() {
            presentLoginVC()
        } else {
            presentDonateMoneyVC()
        }
    }
    @objc
    private func clickBackButton() {
        popNavigationVC()
    }
    
    // MARK: - Methods
    private func showParticipantsAlert() {
        let alert: UIAlertController = UIAlertController(title: "준비중입니다.", message: "빠른 시일 내로 참여자 확인이 가능하도록 하겠습니다.", preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func presentDonateMoneyVC() {
        let donateMoneyVC: DonateMoneyViewController = DonateMoneyViewController(postId: viewModel.getDonationId(), nickname: viewModel.getNickname(), giftName: viewModel.getGiftName())
        donateMoneyVC.donationCompletionHander = { [weak self] in
            self?.viewModel.callDonationInfoAPI()
        }
        let navigationController: UINavigationController = UINavigationController(rootViewController: donateMoneyVC)
        navigationController.modalPresentationStyle = .overFullScreen
        present(navigationController, animated: true)
    }
    
    private func presentLoginVC() {
        let loginVC: LoginViewController = LoginViewController()
        let navVc: UINavigationController = UINavigationController(rootViewController: loginVC)
        navVc.modalPresentationStyle = .fullScreen
        self.present(navVc, animated: true)
    }
    
    private func popNavigationVC() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - DonationDetailViewModelDelegate
extension DonationDetailViewController: DonationDetailViewModelDelegate {
    
    func didImageChanged(to url: String?) {
        guard let url = url else {
            detailImageView.image = placeholderImage
            return
        }
        detailImageView.kf.setImage(with: URL(string: url), placeholder: placeholderImage)
    }
    func didProfileImageChanged(to url: String?) {
        guard let url = url else {
            profileImageView.image = placeholderImage
            return
        }
        profileImageView.kf.setImage(with: URL(string: url), placeholder: placeholderImage)
    }
    func didPublisherChanged(to nickname: String) {
        nameLabel.text = nickname
        wantLabel.text = "\(getZosa(after: nickname))원하는"
        donationButton.setTitle("\(nickname)에게 후원하기", for: .normal)
    }
    func getZosa(after string: String) -> String {
        guard let lastChar = string.last, let unicode = UnicodeScalar(String(lastChar))?.value else { return "" }
        if unicode < 0xAC00 || unicode > 0xD7A3 { return "" } // 한글이 아니면 "" 반환
        let fianlWord = (unicode - 0xAC00) % 28 // 종성 확인
        return fianlWord > 0 ? "이 " : "가 " // 받침있으면 "이" 없으면 "가" 반환
    }
    func didTitleChanged(to title: String) {
        giftLabel.text = title
        navigationItem.title = title
    }
    func didDesciptionChanged(to description: String) {
        descriptionLabel.text = description
    }
    func didProgressChanged(current: Int, goal: Int) {
        progress = goal == 0 ? 100.0 : Float(current) / Float(goal)
        progressLabel.text = "\(Int(progress * 100))%"
        destinationNumberLabel.text = goal.changeToCommaFormat()
        fundAmountNumberLabel.text = current.changeToCommaFormat()
        
        view.setNeedsUpdateConstraints()
    }
    func didEndDateChanged(to date: Date?) {
        guard let date = date else {
            endDateLabel.text = "YYYY.MM.dd"
            dDayLabel.text = "D-알수없음"
            return
        }
        
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
