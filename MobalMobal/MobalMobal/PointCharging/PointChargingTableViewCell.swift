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
    let pointPriceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 15)
        label.textColor = .white
        return label
    }()
    let cellDetailButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "arrowChevronBigRight"), for: .normal)
        return button
    }()
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
        self.setCellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    private func setLayout() {
        [pointPriceLabel, cellDetailButton].forEach { contentView.addSubview($0) }
        pointPriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.bottom.equalToSuperview().inset(28)
            make.leading.equalToSuperview()
        }
        cellDetailButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(pointPriceLabel)
//            make.leading.lessThanOrEqualTo(pointPriceLabel.snp.trailing).offset(225)
            make.trailing.equalToSuperview()
        }
    }
    private func setCellStyle() {
        self.backgroundColor = .darkGreyTwo
        self.selectionStyle = .none
    }
}
