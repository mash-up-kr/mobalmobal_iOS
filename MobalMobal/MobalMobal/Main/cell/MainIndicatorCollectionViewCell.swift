//
//  MainIndicatorCollectionViewCell.swift
//  MobalMobal
//
//  Created by JHKim on 2021/04/10.
//

import UIKit

class MainIndicatorCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponent
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        return indicatorView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .darkGrey
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    private func setLayout() {
        [activityIndicatorView].forEach { contentView.addSubview($0) }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func animationIndicatorView() {
        activityIndicatorView.startAnimating()
    }
}
