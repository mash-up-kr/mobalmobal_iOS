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

protocol MainMyOngoingDonationDelegate: AnyObject {
    func populate()
}
class MainMyOngoingDonationCollectionViewCell: UICollectionViewCell, MainMyOngoingDonationDelegate {
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
    
    lazy var donationImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: donateImage[0])
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Properties
    private let donateImage: [UIImage?] = [
        UIImage(named: "process-00_yanudo"),
        UIImage(named: "process-01_poor-guji"),
        UIImage(named: "process-02_chicken"),
        UIImage(named: "process-03_shopping"),
        UIImage(named: "process-04_chanel-girl"),
        UIImage(named: "process-05_rich")
    ]
    let viewModel: MainViewModel = MainViewModel()
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
        viewModel.mainMyOngoingDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setModel(title: String, money: Int, progress: Float, indexPath: Int) {
        self.model = MainMyDonationModel(title: title, progress: progress, money: money, indexPathRow: indexPath)
    }
    func populate() {
        donationTitleLabel.text = model.title
        donationPointLabel.text = model.money.changeToCommaFormat()
        setImage()
    }
    private func setImage() {
        if model.progress == 0.0 {
            donationImageView.image = donateImage[0]
        } else if 0.0..<25.0 ~= model.progress {
            donationImageView.image = donateImage[1]
        } else if 25.0..<50.0 ~= model.progress {
            donationImageView.image = donateImage[2]
        } else if 50.0..<75.0 ~= model.progress {
            donationImageView.image = donateImage[3]
        } else if 75.0..<100.0 ~= model.progress {
            donationImageView.image = donateImage[4]
        } else {
            donationImageView.image = donateImage[5]
        }
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
