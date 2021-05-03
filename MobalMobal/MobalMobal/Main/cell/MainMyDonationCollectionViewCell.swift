//
//  MainMyDonationCollectionViewCell.swift
//  MobalMobal
//
//  Created by 김재희 on 2021/02/28.
//

import SnapKit
import UIKit

protocol MainMyDonationCollectionViewCellDelegate: AnyObject {
    func didSelectAddMyDonationButton()
    func didSelectMyOngoingDonationItem(at indexPath: IndexPath)
}

class MainMyDonationCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponents
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    let headerLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.text = "나의 진행"
        label.textColor = .veryLightPink
        label.font = .spoqaHanSansNeo(ofSize: 14, weight: .regular)
        return label
    }()
    
    // MARK: - Properties
    weak var delegate: MainMyDonationCollectionViewCellDelegate?
    
    let buttonCellIdentifier: String = "MainAddMyDonationCollectionViewCell"
    let cardCellIdentifier: String = "MainMyOngoingDonationCollectionViewCell"
    let viewModel: MainViewModel = MainViewModel()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionView()
        setLayout()
        callAPI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func callAPI(){
        viewModel.callMyDonationAPI { result in
            switch result {
            case .success:
                self.collectionView.reloadData()
            case .failure(.client), .failure(.noData), .failure(.server), .failure(.unknown):
                print("fail")
            }
        }
    }
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MainAddMyDonationCollectionViewCell.self, forCellWithReuseIdentifier: buttonCellIdentifier)
        collectionView.register(MainMyOngoingDonationCollectionViewCell.self, forCellWithReuseIdentifier: cardCellIdentifier)
    }
    
    private func setLayout() {
        [collectionView, headerLabel].forEach { contentView.addSubview($0) }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.leading.trailing.equalToSuperview().inset(22)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainMyDonationCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            delegate?.didSelectAddMyDonationButton()
        case 1:
            delegate?.didSelectMyOngoingDonationItem(at: indexPath)
        default:
            break
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainMyDonationCollectionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.getMyDonationsCount
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: buttonCellIdentifier, for: indexPath) as? MainAddMyDonationCollectionViewCell else { return .init() }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifier, for: indexPath) as? MainMyOngoingDonationCollectionViewCell else { return .init() }
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainMyDonationCollectionViewCell: UICollectionViewDelegateFlowLayout {
    // cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: 65, height: 142)
        default:
            return CGSize(width: 258, height: 142)
        }
    }
    
    // section inset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 0.0, left: 22.0, bottom: 0.0, right: 0.0)
        case 1:
            return UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 22.0)
        default:
            return .zero
        }
    }
    
    // cell 사이의 간격
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 1:
            return 10
        default:
            return 0
        }
    }
}
