//
//  DonatingTableViewCell.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/28.
//

import Kingfisher
import SnapKit
import UIKit

class ProfileDonatingTableViewCell: UITableViewCell {
    // MARK: - UIComponents
    private let donateContentView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .darkGrey
        return view
    }()
    private lazy var donateImg: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 12
        image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        image.layer.masksToBounds = true
        return image
    }()
    private let translucentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black40
        return view
    }()
    private lazy var donateDday: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .brownGrey
        return label
    }()
    private lazy var donatePrice: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    private lazy var donateInfoStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        [donateDday, donatePrice].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    private let ratingBackgroundBar: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .brownishGrey
        return view
    }()
    private let ratingBar: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .wheat
        view.layer.shadowColor = UIColor.lemonLime80.cgColor
        view.layer.shadowRadius = 10 / UIScreen.main.scale
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 1
        return view
    }()
    private lazy var donateTitle: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = .spoqaHanSansNeo(ofSize: 14, weight: .medium)
        return label
    }()
   
    // MARK: - Properties
    let viewModel: ProfileDonatingViewModel = ProfileDonatingViewModel()
    var headerLabelText: String?
    private var ratingBarWidth: Float = 0.0
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .backgroundColor
        setViewHierarchy()
        setLayout()
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setViewHierarchy() {
        self.contentView.addSubviews([donateContentView])
        self.donateImg.addSubview(translucentView)
        translucentView.addSubview(donateInfoStackView)
        self.donateContentView.addSubviews([donateImg, ratingBackgroundBar, donateTitle])
        self.ratingBackgroundBar.addSubview(ratingBar)
    }
    func setDonationImageLayout() {
        donateImg.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(124.5)
        }
        translucentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        donateInfoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.leading.trailing.equalToSuperview().inset(23)
            make.bottom.equalToSuperview().inset(63.5)
        }
    }
    func setRatingBarLayout() {
        ratingBackgroundBar.snp.makeConstraints { make in
            make.top.equalTo(donateImg.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        ratingBar.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(ratingBarWidth)
        }
    }
    func setLayout() {
        donateContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
        setDonationImageLayout()
        setRatingBarLayout()
        donateTitle.snp.makeConstraints { make in
            make.top.equalTo(ratingBackgroundBar.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(25)
        }
    }
    func didEndDateChanged(to date: Date) {
        let dueDay: Int = Date().getDueDay(of: date)
        if dueDay > 0 {
            donateDday.text = "D-\(dueDay)"
        } else if dueDay == 0 {
            donateDday.text = "D-Day"
        } else {
            donateDday.text = "D+\(-dueDay)"
        }
    }
}

// MARK: - ProfileDonatingViewModelDelegate
extension ProfileDonatingTableViewCell: ProfileDonatingViewModelDelegate {
    func setMyDonationUI(mydonate: Bool) {
        guard let donationGoal: Int = viewModel.getGoal(myDonate: mydonate) else {
            return
        }
        if let donationGoalFormat: String = donationGoal.changeToCommaFormat() {
            donatePrice.text = "\(donationGoalFormat)"
        }
        if let imageURL: URL = URL(string: viewModel.getDonationImg(myDonate: mydonate) ?? "") {
            donateImg.kf.setImage(with: imageURL, placeholder: UIImage(named: "profile_default"), options: nil, completionHandler: nil)
        } else {
            donateImg.image = UIImage(named: "profile_default")
        }
        if let donationTitle: String = viewModel.getTitle(myDonate: mydonate) {
            donateTitle.text = "\(donationTitle)"
        }
        if let donationDate: Date = viewModel.getDate(myDonate: mydonate) {
            didEndDateChanged(to: donationDate)
        }
        if let currentAmount: Int = viewModel.getCurrentAmount(myDonate: mydonate) {
            let ratingBackgroundBarWidth: Float = Float(UIScreen.main.bounds.width) - 40.0
            
            // goal : 전체길이 = currentAmount : 보여질길이
            ratingBarWidth = donationGoal == 0 ? 100.0 : Float((ratingBackgroundBarWidth * Float(currentAmount))) / Float(donationGoal)
            if ratingBarWidth >= ratingBackgroundBarWidth {
                ratingBarWidth = ratingBackgroundBarWidth
            }
            ratingBar.snp.updateConstraints { make in
                make.width.equalTo(ratingBarWidth)
            }
        }
    }
}
