//
//  MainMyDonationTableViewCell.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/28.
//

import SnapKit
import UIKit

class MainMyDonationTableViewCell: UITableViewCell {
    // MARK: - UIComponent
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .backgroundColor
        return collectionView
    }()
    
    // MARK: - property
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("🐰 \(reuseIdentifier)")
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setLayout() {
        [collectionView].forEach { contentView.addSubview($0) }
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
//        let view: UIView = UIView(frame: .zero)
//        view.backgroundColor = .brown
//        [view].forEach { contentView.addSubview($0) }
//        view.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainMyDonationTableViewCell: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource
extension MainMyDonationTableViewCell: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        2
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//        case 1:
//            return 10
//        default:
//            return 0
//        }
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch indexPath.item {
//        case 0:
//            let cell: UICollectionViewCell = UICollectionViewCell()
//            cell.backgroundColor = .green
//            return cell
//        case 1:
//            let cell: UICollectionViewCell = UICollectionViewCell()
//            cell.backgroundColor = .systemPink
//            return cell
//        default:
//            return .init()
//        }
        let cell: UICollectionViewCell = UICollectionViewCell()
        cell.backgroundColor = .green
        return cell
    }
}

extension MainMyDonationTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 50, height: 50)
    }
}
