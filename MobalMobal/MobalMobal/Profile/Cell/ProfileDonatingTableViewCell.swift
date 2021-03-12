//
//  DonatingTableViewCell.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/28.
//

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
        image.image = UIImage(named: "\(self.imageName)")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 24
        image.layer.masksToBounds = true
        return image
    }()
    private let translucentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black70
        return view
    }()
    private lazy var donateDday: UILabel = {
        let label: UILabel = UILabel()
        label.text = "D- \(self.dDay)"
        label.font = UIFont(name: "Lato-Regular", size: 11)
        label.textColor = .brownGrey
        return label
    }()
    private lazy var donatePrice: UILabel = {
        let label: UILabel = UILabel()
        label.text = "\(self.price)"
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
        label.text = "\(self.donateName)"
        label.textColor = .white
        label.font = .spoqaHanSansNeo(ofSize: 14, weight: .medium)
        return label
    }()
   
    // MARK: - Properties
    // dummy data
    private let dDay: Int = 12
    private let price: String = "153,000"
    private let donateName: String = "티끌모아 닌텐도스위치"
    private let imageName: String = "doneImage"
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .backgroundColor
        setViewHierarchy()
        setLayout()
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
            make.width.equalTo(182)
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
}
