//
//  MainOngoingDonationHeaderView.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/29.
//

import UIKit

class MainOngoingDonationHeaderView: UICollectionReusableView {
    let headerLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "진행중"
        label.textColor = .veryLightPink
        label.font = .spoqaHanSansNeo(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(22)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
