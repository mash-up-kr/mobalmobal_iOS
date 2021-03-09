//
//  CustomLoginButton.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/02/28.
//
import SnapKit
import UIKit

class CustomLoginButton: UIView {
    let stackView: UIStackView = UIStackView()
    
    let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Futura-Medium", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let iconImageView: UIImageView = UIImageView()
    
    init(title: String, iconName: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = UIColor(displayP3Red: 255, green: 255, blue: 255, alpha: 0.2)
    
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        [iconImageView, titleLabel].forEach { stackView.addArrangedSubview($0) }
        titleLabel.text = title
        if let icon: UIImage = UIImage(named: iconName) {
            iconImageView.image = icon
        }
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
