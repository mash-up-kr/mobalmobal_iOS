//
//  CustomLoginButton.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/02/28.
//
import SnapKit
import UIKit

class CustomLoginButton: UIView {
    // MARK: - Properties
    let titleText: String
    let iconName: String
    
    // MARK: - UI Components
    let stackView: UIStackView = UIStackView()
    
    lazy var iconImageView: UIImageView = UIImageView(image: UIImage(named: iconName))
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        label.text = titleText
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    init(title: String, iconName: String) {
        self.titleText = title
        self.iconName = iconName
        
        super.init(frame: .zero)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func updateConstraints() {
        [stackView].forEach { self.addSubview($0) }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        [iconImageView, titleLabel].forEach { stackView.addArrangedSubview($0) }
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        self.roundCorner()
        super.layoutSubviews()
    }
    
    private func setupView() {
        self.backgroundColor = .white20
    }
}
