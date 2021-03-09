//
//  SuccessChargingViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/03/09.
//

import SnapKit
import UIKit

class SuccessChargingViewController: UIViewController {
    // MARK: - UIComponents
    private let closeBtn: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "menuCloseBig"), for: .normal)
        return button
    }()
    private let successImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "chargingComplete")
        return imageView
    }()
    lazy var successLabel: UILabel = {
        let label: UILabel = UILabel()
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "\(self.point)원\n충전완료")
        let emphasisAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.spoqaHanSansNeo(ofSize: 36, weight: .medium)
        ]
        let defaultAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.veryLightPink,
            .font: UIFont.spoqaHanSansNeo(ofSize: 36, weight: .regular)
        ]
        attributedString.addAttributes(defaultAttributes, range: _NSRange(location: 0, length: attributedString.length))
        attributedString.addAttributes(emphasisAttributes, range: NSRange(location: 0, length: self.point.count + 1))
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Properties
    // dummy data
    let point: String = "30,000"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("✨ successcharging")
        self.view.backgroundColor = .backgroundColor
        setLayout()
    }
    
    // MARK: - Methods
    private func setLayout() {
        self.view.addSubviews([closeBtn, successLabel, successImage])
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(46)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(44)
        }
        successLabel.snp.makeConstraints { make in
            make.top.equalTo(closeBtn.snp.bottom).offset(86)
            make.centerX.equalToSuperview()
        }
        successImage.snp.makeConstraints { make in
            make.top.equalTo(successLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(175)
        }
    }
}
