//
//  MainViewController.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/27.
//

import SnapKit
import Then
import UIKit

class MainViewController: UIViewController {
    // MARK: - UIComponent
    let titleView: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.text = "Hi, jaehui"
        label.font = UIFont(name: "Futura-Bold", size: 30)
        label.textColor = .white
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "icMyProfile")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let notiListButton: UIButton = {
        let button: UIButton = UIButton(frame: .zero)
        button.setImage(UIImage(named: "icAlarm"), for: .normal)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.layer.masksToBounds = true
        collectionView.clipsToBounds = true
        
        return collectionView
    }()
    
    // MARK: - property
    var lastContentOffset: CGFloat = 0.0
    
    private let itemsPerRow: CGFloat = 2
    private let firstSectionInsets: UIEdgeInsets = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
    private let secondSectionInsets: UIEdgeInsets = UIEdgeInsets(top: 15.0, left: 22.0, bottom: 0.0, right: 22.0)
    
    let sectionTitle: [String] = ["나의 진행", "진행중"]
    let myCellIdentifier: String = "MainMyDonationCollectionViewCell"
    let ongoingCellIdentifier: String = "MainOngoingDonationCollectionViewCell"
    let ongoingHeaderIdentifier: String = "MainOngoingDonationHeaderView"
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setCollectionView()
        setLayout()
    }
    
    // MARK: - Action
    
    // MARK: - Method
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MainMyDonationCollectionViewCell.self, forCellWithReuseIdentifier: myCellIdentifier)
        collectionView.register(MainOngoingDonationCollectionViewCell.self, forCellWithReuseIdentifier: ongoingCellIdentifier)
        collectionView.register(MainOngoingDonationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ongoingHeaderIdentifier)
    }
    
    private func setLayout() {
        view.addSubviews([titleView, collectionView])
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        titleView.addSubviews([titleLabel, profileImageView, notiListButton])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(22)
            make.bottom.equalToSuperview().inset(10)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(44)
        }
        
        notiListButton.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(44)
        }
    }
}
extension MainViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset <= 0 {
            titleLabel.font = UIFont(name: "Futura-Bold", size: 25)
            titleLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(30)
            }
        } else if self.lastContentOffset < scrollView.contentOffset.y {
            titleLabel.font = UIFont(name: "Futura-Bold", size: 16)
            titleLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(13)
            }
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 13
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: myCellIdentifier, for: indexPath) as? MainMyDonationCollectionViewCell else { return .init() }
            return cell
            
        default:
            guard let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ongoingCellIdentifier, for: indexPath) as? MainOngoingDonationCollectionViewCell else { return .init() }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView: MainOngoingDonationHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ongoingHeaderIdentifier, for: indexPath as IndexPath) as? MainOngoingDonationHeaderView else { return .init() }
            return headerView
        default:
            return .init()
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            let availableWidth: CGFloat = view.frame.width - (firstSectionInsets.left * 2)
            return CGSize(width: availableWidth, height: 142)
            
        case 1:
            let insetSpace: CGFloat = secondSectionInsets.left * 2
            let paddingSpace: CGFloat = 12 * (itemsPerRow - 1)
            let availableWidth: CGFloat = view.frame.width - insetSpace - paddingSpace
            let widthPerItem: CGFloat = availableWidth / itemsPerRow
            let heightPerItem: CGFloat = widthPerItem / 159 * 198
            return CGSize(width: widthPerItem, height: heightPerItem)
            
        default:
            return .zero
        }
    }
    
    // cell이 들어갈 inset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return firstSectionInsets
        case 1:
            return secondSectionInsets
        default:
            return .zero
        }
    }
    
    // cell 사이의 간격
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 1:
            return 12
        default:
            return 0
        }
    }
    
    // header size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 1:
            return CGSize(width: view.frame.width, height: 59)
        default:
            return .zero
        }
    }
}
