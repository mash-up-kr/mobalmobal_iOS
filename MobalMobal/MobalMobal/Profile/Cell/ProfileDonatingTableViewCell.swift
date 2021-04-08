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
    private lazy var cellHeaderLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.text = headerLabelText
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
        return label
    }()
    private let donateContentView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .darkGrey
        return view
    }()
    private lazy var donateImg: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    private let translucentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black70
        return view
    }()
    private lazy var donateDday: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Lato-Regular", size: 11)
        label.textColor = .brownGrey
        return label
    }()
    private lazy var donatePrice: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Lato-Bold", size: 18)
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
    private let numberFormat: (Int) -> String = { number in
        let str: String = "\(number)"
        let regex: NSRegularExpression?
        do {
            regex = try? NSRegularExpression(pattern: "(?<=\\d)(?=(?:\\d{3})+(?!\\d))", options: [])
        }
        guard let regexString = regex else { return "" }
        return regexString.stringByReplacingMatches(in: str,
                                                    options: [],
                                                    range: NSRange(location: 0, length: str.count),
                                                    withTemplate: ",")
    }
    
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
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
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
    func setUIFromModel(row: Int) {
        guard let donationGoal: Int = viewModel.getGoal(row: row) else {
            return
        }
        donatePrice.text = "\(numberFormat(donationGoal))"
        
        // image Placeholder 없음..!
        if let imageURL: URL = URL(string: viewModel.getDonationImg(row: row) ?? "") {
            donateImg.kf.setImage(with: imageURL)
            donateImg.layer.cornerRadius = 24
            donateImg.layer.masksToBounds = true
        }
        if let donationTitle: String = viewModel.getTitle(row: row) {
            donateTitle.text = "\(donationTitle)"
        }
        if let donationDate: Date = viewModel.getDate(row: row) {
            didEndDateChanged(to: donationDate)
        }
        if let currentAmount: Int = viewModel.getCurrentAmount(row: row) {
            let ratingBackgroundBarWidth: Float = Float(ratingBackgroundBar.bounds.width)
            // goal : 전체길이 = currentAmount : 보여질길이
            ratingBarWidth = Float((ratingBackgroundBarWidth * Float(currentAmount))) / Float(donationGoal)
            print(ratingBarWidth)
            ratingBar.snp.updateConstraints { make in
                make.width.equalTo(ratingBarWidth)
            }
        }
    }
}
