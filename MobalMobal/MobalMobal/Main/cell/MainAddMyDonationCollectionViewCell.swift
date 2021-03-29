//
//  MainAddMyDonationCollectionViewCell.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/28.
//

import SnapKit
import UIKit

class MainAddMyDonationCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponents
    let buttonView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = .black
        view.layer.cornerRadius = 16
        
        let imageView: UIImageView = UIImageView(image: UIImage(named: "iconlyLightPlus"))
        [imageView].forEach { view.addSubview($0) }
        imageView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.center.equalToSuperview()
        }
        
        return view
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setLayout() {
        [buttonView].forEach { contentView.addSubview($0) }
        buttonView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(68)
            make.centerX.equalToSuperview()
            make.size.equalTo(65)
        }
    }
}
