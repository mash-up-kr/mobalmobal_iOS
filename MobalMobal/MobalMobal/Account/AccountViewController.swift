//
//  AccountViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/03/11.
//

import SnapKit
import UIKit

class AccountViewController: UIViewController {
    // MARK: - UIComponents
    private lazy var accountLabel: UILabel = {
        let label: UILabel = UILabel()
        let accountLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: "\(self.account) \(self.bankName)으로")
        let underLineAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white ,
            .font: UIFont.spoqaHanSansNeo(ofSize: 18, weight: .medium),
            .underlineStyle: 1
        ]
        accountLabelAttributedString.addAttributes(defaultAttributes, range: NSRange(location: 0, length: accountLabelAttributedString.length))
        accountLabelAttributedString.addAttributes(underLineAttributes, range: NSRange(location: 0, length: self.account.count))
        accountLabelAttributedString.addAttributes(underLineAttributes, range: NSRange(location: self.account.count + 1, length: self.bankName.count))
       
        label.attributedText = accountLabelAttributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label: UILabel = UILabel()
        let priceLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: "\(self.charge)원을 보내주세요")
        let emphasisAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white ,
            .font: UIFont.spoqaHanSansNeo(ofSize: 18, weight: .medium)
        ]
        priceLabelAttributedString.addAttributes(defaultAttributes, range: NSRange(location: 0, length: priceLabelAttributedString.length))
        priceLabelAttributedString.addAttributes(emphasisAttributes, range: _NSRange(location: 0, length: self.charge.count + 1))
        
        label.attributedText = priceLabelAttributedString
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let accountImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "errorImage")
        return imageView
    }()
    private let accountDetailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "충전이 완료되면 연락드릴게요"
        label.textColor = .white
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .regular)
        return label
    }()
    private let closeButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "menuCloseBig"), for: .normal)
        button.addTarget(self, action: #selector(closeBtn), for: .touchUpInside)
        return button
    }()
    private lazy var verticalStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.addArrangedSubview(accountLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(accountImageView)
        stackView.addArrangedSubview(accountDetailLabel)
        stackView.setCustomSpacing(0, after: accountLabel)
        stackView.setCustomSpacing(40, after: priceLabel)
        stackView.setCustomSpacing(24, after: accountImageView)
        return stackView
    }()
    
    // MARK: - Properties
    // dummy data
    var account: String = "110-436-3412421"
    var bankName: String = "신한은행"
    var charge: String = "30,000"
    
    private var setLayoutFlag: Bool = false
    private let defaultAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.veryLightPink ,
        .font: UIFont.spoqaHanSansNeo(ofSize: 18, weight: .regular)
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        accountLabelTapGesture()
        self.view.backgroundColor = .backgroundColor
    }
    override func updateViewConstraints() {
        if !setLayoutFlag {
            self.view.addSubviews([verticalStackView, closeButton])
            closeButton.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide)
                make.trailing.equalToSuperview().inset(10)
                make.size.equalTo(44)
            }
            verticalStackView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            setLayoutFlag = true
        }
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    @objc
    private func closeBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc
    private func copyAccount() {
        UIPasteboard.general.string = self.account
        print("✨ copy 완료 \(self.account) \(self.bankName)")
    }
    
    // MARK: - Methods
    private func accountLabelTapGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(copyAccount))
        accountLabel.isUserInteractionEnabled = true
        accountLabel.addGestureRecognizer(tapGesture)
    }
}
