//
//  MainOngoingDonationCollectionViewCell.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/28.
//

import SnapKit
import UIKit

class MainOngoingDonationCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponents
    private let thumbnailImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "profile_default")
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let translucentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black70
        return view
    }()
    
    private let progressBackgroundView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .brownishGrey
        return view
    }()
    
    private let progressBarView: UIView = {
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
    
    private lazy var dDayLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = dday
        label.textColor = .brownGrey
        label.font = .spoqaHanSansNeo(ofSize: 11, weight: .regular)
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = money
        label.textColor = .white
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = title
        label.textColor = .white
        label.font = .spoqaHanSansNeo(ofSize: 13, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Properties
    // dummy data
    var dday: String = "D-12"
    var money: String = "123,456"
    var title: String = "티끌모아 닌텐도 스위치 사주세요 제발요 부탁드립니다!!!!!!"
    var progress: Float = 0.3
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .darkGrey
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        contentView.addSubviews([thumbnailImageView, translucentView, progressBackgroundView, dDayLabel, moneyLabel, titleLabel])
        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(124)
        }
        translucentView.snp.makeConstraints { make in
            make.edges.equalTo(thumbnailImageView)
        }
        progressBackgroundView.snp.makeConstraints { make in
            make.centerY.equalTo(translucentView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        dDayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(dDayLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(dDayLabel)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(translucentView.snp.bottom).offset(22)
            make.leading.trailing.equalTo(dDayLabel)
        }
        
        progressBackgroundView.addSubview(progressBarView)
        progressBarView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().multipliedBy(progress)
        }
        
        super.layoutSubviews()
    }
    
    // MARK: - Methods
}
