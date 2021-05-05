//
//  PointChargingTableViewCell.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/27.
//

import SnapKit
import UIKit

class PointChargingTableViewCell: UITableViewCell {
    // MARK: - UIComponents
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        guard let image: UIImage = UIImage(named: "arrowChevronBigRight") else {
            imageView.backgroundColor = .white
            return imageView
        }
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setCellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func updateConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(51)
        }
        contentView.addSubviews([titleLabel, arrowImageView])
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(24)
        }
        super.updateConstraints()
    }
    private func setCellStyle() {
        self.backgroundColor = .darkGreyTwo
        self.selectionStyle = .none
    }
}
