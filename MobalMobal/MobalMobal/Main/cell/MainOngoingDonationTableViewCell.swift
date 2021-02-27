//
//  MainOngoingDonationTableViewCell.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/28.
//

import UIKit

class MainOngoingDonationTableViewCell: UITableViewCell {
    // MARK: - UIComponent
    let collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .backgroundColor
        return collectionView
    }()
    
    let headerLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.text = "진행중"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .veryLightPink
        return label
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - property

    // MARK: - Method
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setLayout() {
        [headerLabel, collectionView].forEach { contentView.addSubview($0) }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.leading.trailing.equalToSuperview().inset(22)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(14)
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
