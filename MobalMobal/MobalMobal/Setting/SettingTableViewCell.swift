//
//  SettingTableViewCell.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/27.
//

import SnapKit
import UIKit

class SettingTableViewCell: UITableViewCell {
    private let cellIdentifier: String = "settingTableViewCell"
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "futura", size: 18)
        label.textColor = .black
        return label
    }()
    
    private func setup() {
        self.contentView.addSubview(titleLabel)
        self.setConstraint()
    }
    
    private func setConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.top.equalTo(15)
            make.bottom.equalTo(15)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: cellIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
