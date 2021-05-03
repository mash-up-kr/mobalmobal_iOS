//
//  MainMyOngoingDonationCollectionViewCell.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/28.
//

import SnapKit
import UIKit

struct MainMyDonationModel {
    let title: String
    let progress: Float
    let money: Int
    let indexPathRow: Int
}

class MainMyOngoingDonationCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponents
    let cardView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = .purpleishBlue
        view.layer.cornerRadius = 12
        return view
    }()
    
    let donationTitleLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "야 너두 할 수 있어"
        label.textColor = .white
        return label
    }()
    
    let donationPointLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.text = "0"
        label.textColor = .white
        return label
    }()
    
    let donationImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: "process-01_poor-guji"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var model: MainMyDonationModel {
        didSet {
            populate()
        }
    }
    // MARK: - Initializer
    override init(frame: CGRect) {
        self.model = MainMyDonationModel(title: "default", progress: 0.0, money: 0, indexPathRow: 0)
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setModel(title: String, money: Int, progress: Float, indexPath: Int) {
        self.model = MainMyDonationModel(title: title, progress: progress, money: money, indexPathRow: indexPath)
    }
    private func populate() {
        donationTitleLabel.text = model.title
        donationPointLabel.text = "\(model.money)"
    }
    private func setLayout() {
        [cardView].forEach { contentView.addSubview($0) }
        
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(55)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        [donationImageView, donationTitleLabel, donationPointLabel].forEach { cardView.addSubview($0) }
        
        donationImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(-10)
            make.bottom.equalToSuperview()
            make.width.equalTo(172)
            make.height.equalTo(135)
        }
        
        donationTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(18)
        }
        
        donationPointLabel.snp.makeConstraints { make in
            make.top.equalTo(donationTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(donationTitleLabel)
        }
    }
}
