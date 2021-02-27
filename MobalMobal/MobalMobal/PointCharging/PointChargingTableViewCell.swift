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
        return label
    }()
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    private func setLayout() {
        [pointPriceLabel].forEach { contentView.addSubview($0) }
        pointPriceLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
        }
    }
}
