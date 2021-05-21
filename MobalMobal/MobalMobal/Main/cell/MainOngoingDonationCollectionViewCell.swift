//
//  MainOngoingDonationCollectionViewCell.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/28.
//

import Kingfisher
import SnapKit
import UIKit

struct OngoingDonationModel {
    let dday: Date
    let money: Int
    let title: String
    let progress: Float
    let indexPath: IndexPath
    let description: String
}

class MainOngoingDonationCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponents
    private lazy var thumbnailImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = placeholderImage
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let translucentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black40
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
        label.textColor = .brownGrey
        label.font = .spoqaHanSansNeo(ofSize: 11, weight: .regular)
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = .spoqaHanSansNeo(ofSize: 13, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Properties
    let placeholderImage: UIImage = UIImage(named: "profile_default")!
    private var model: OngoingDonationModel {
        didSet {
            populate()
        }
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        self.model = OngoingDonationModel(dday: Date(), money: 0, title: "갖고 싶은 물건", progress: 0.0, indexPath: IndexPath(item: -1, section: -1), description: "물건설명")
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
            make.top.equalTo(thumbnailImageView.snp.bottom)
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
        
        super.layoutSubviews()
    }
    
    // MARK: - Methods
    func isIndexPathEqual(with indexPath: IndexPath) -> Bool {
        self.model.indexPath == indexPath
    }
    func setModel(dday: Date, money: Int, title: String, progress: Float, indexPath: IndexPath, description: String) {
        self.model = OngoingDonationModel(dday: dday, money: money, title: title, progress: progress, indexPath: indexPath, description: description)
    }
    func setImage(_ image: UIImage?) {
        guard let image = image else {
            self.thumbnailImageView.image = placeholderImage
            return
        }
        self.thumbnailImageView.image = image
    }
    private func populate() {
        dDayLabel.text = Date().getDDayString(to: model.dday)
        moneyLabel.text = model.money.changeToCommaFormat()
        titleLabel.text = "\(model.title)\n\(model.description)"
        progressBarView.snp.removeConstraints()
        progressBackgroundView.addSubview(progressBarView)
        progressBarView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.lessThanOrEqualToSuperview().multipliedBy(model.progress)
        }
    }
}
