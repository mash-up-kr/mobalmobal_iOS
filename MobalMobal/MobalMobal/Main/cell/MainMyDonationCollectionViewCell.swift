//
//  MainMyDonationCollectionViewCell.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/28.
//

import UIKit

class MainMyDonationCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponent
    let donationTitleLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 13)
        label.text = "야 너두 할 수 있어"
        label.tintColor = .white
        return label
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
}
