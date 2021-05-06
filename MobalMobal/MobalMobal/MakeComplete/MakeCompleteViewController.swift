//
//  MakeCompleteViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/10.
//

import SnapKit
import UIKit
import Kingfisher

class MakeCompleteViewController: UIViewController {
    // MARK: - Property
    var donationInfo: CreateDonationInfo?
    
    // MARK: - UIComponenets
    let closeButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "menuCloseBig"), for: .normal)
        button.addTarget(self, action: #selector(clickCloseButton), for: .touchUpInside)
        return button
    }()
    lazy var giftLabel: UILabel = {
        let label: UILabel = UILabel()
        if let title = donationInfo?.title, let description = donationInfo?.description {
            label.text = "\(title) \(description)"
        }
        label.numberOfLines = 3
        label.font = .spoqaHanSansNeo(ofSize: 36, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    let completeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "생성완료"
        label.font = .spoqaHanSansNeo(ofSize: 36, weight: .regular)
        label.textColor = .veryLightPink
        label.textAlignment = .center
        return label
    }()
    lazy var donationImageView: UIImageView = {
        let url = URL(string: donationInfo?.postImage ?? "")
        let imageView: UIImageView = UIImageView()
        imageView.kf.setImage(with: url)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    lazy var transparentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black40
        return view
    }()
    lazy var ddayLabel: UILabel = {
        let label: UILabel = UILabel()
        let dDay = Date().getDDayString(to: donationInfo?.endAt)
        label.text = "\(dDay)"
        label.font = .spoqaHanSansNeo(ofSize: 11, weight: .regular)
        label.textColor = .brownGrey
        return label
    }()
    let divider: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .brownishGrey
        return view
    }()
    lazy var smallTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 2
        if let title = donationInfo?.title {
            label.text = "\(title)"
        }
        label.font = .spoqaHanSansNeo(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    // 공유버튼 차후 추가 예정
    
    lazy var labelGroup: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(giftLabel)
        stackView.addArrangedSubview(completeLabel)
        return stackView
    }()
    lazy var bottomView: UIView = {
        let view: UIView = UIView()
        view.addSubview(smallTitleLabel)
        return view
    }()
    lazy var donationItemView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .darkGrey
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.addSubviews([donationImageView, transparentView, ddayLabel, divider, bottomView])
        return view
    }()
    lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        [labelGroup, donationItemView].forEach { stackView.addArrangedSubview($0) }
        stackView.setCustomSpacing(45, after: labelGroup)
        return stackView
    }()
    
    // MARK: - Properties
    var gift: String = "PS5"
    var dday: Int = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Methods
    private func setLayout() {
        view.backgroundColor = .backgroundColor
        view.addSubviews([closeButton, stackView])
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(2)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(44)
        }
        donationItemView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(donationItemView.snp.width).multipliedBy(198.0/334.0)
        }
        donationImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(donationImageView.snp.width).multipliedBy(124.5/334.0)
        }
        transparentView.snp.makeConstraints { make in
            make.edges.equalTo(donationImageView)
        }
        ddayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.leading.equalToSuperview().inset(30)
        }
        divider.snp.makeConstraints { make in
            make.top.equalTo(transparentView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        smallTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(25)
        }
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func calculateDday() -> Int {
        return Calendar.current.dateComponents([.year, .month, .day], from: donationInfo!.startedAt, to: donationInfo!.endAt).day! + 1
    }
    
    @objc
    private func clickCloseButton() {
        navigationController?.dismiss(animated: true)
    }
}
