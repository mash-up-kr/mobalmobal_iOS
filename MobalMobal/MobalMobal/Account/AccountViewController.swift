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
    private lazy var accountNameLabel: UILabel = {
        let label: UILabel = UILabel()
        let attributeText: NSMutableAttributedString = NSMutableAttributedString(string: "받는통장표시: \(accountName)")
        attributeText.addAttributes(defaultAttributes, range: NSRange(location: 0, length: attributeText.length))
        attributeText.addAttributes(accountNameAttributes, range: NSRange(location: 8, length: accountName.count))
        
        label.numberOfLines = 0
        label.attributedText = attributeText
        return label
    }()
    private lazy var accountLabel: UILabel = {
        let label: UILabel = UILabel()
        let accountLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: "계좌: \(account) \(bankName)")
        
        accountLabelAttributedString.addAttributes(defaultAttributes, range: NSRange(location: 0, length: accountLabelAttributedString.length))
        accountLabelAttributedString.addAttributes(underLineAttributes, range: NSRange(location: 4, length: self.account.count))
        accountLabelAttributedString.addAttributes(underLineAttributes, range: NSRange(location: 4 + self.account.count + 1, length: self.bankName.count))
       
        label.attributedText = accountLabelAttributedString
        label.numberOfLines = 0
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label: UILabel = UILabel()
        guard let charge = self.charge else { return label }
        let priceLabelAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: "금액: \(charge)")
        
        priceLabelAttributedString.addAttributes(defaultAttributes, range: NSRange(location: 0, length: priceLabelAttributedString.length))
        priceLabelAttributedString.addAttributes(emphasisAttributes, range: _NSRange(location: 4, length: charge.count))
        
        label.attributedText = priceLabelAttributedString
        label.numberOfLines = 0
        return label
    }()
    private lazy var accountViewInfoStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        [accountNameLabel, accountLabel, priceLabel].forEach { stackView.addArrangedSubview($0) }
        stackView.setCustomSpacing(0, after: accountNameLabel)
        stackView.setCustomSpacing(0, after: accountLabel)
        return stackView
    }()
    private let accountImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "pig_01")
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
        [accountViewInfoStackView, accountImageView, accountDetailLabel].forEach { stackView.addArrangedSubview($0) }
        stackView.setCustomSpacing(20, after: accountViewInfoStackView)
        stackView.setCustomSpacing(28, after: accountImageView)
        return stackView
    }()
    
    // MARK: - Properties
    // dummy data
    private var account: String = "7979-33-72352"
    private var bankName: String = "카카오뱅크"
    private var accountName: String = "정민호"
    
    var charge: String?
    private let defaultAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.veryLightPink ,
        .font: UIFont.spoqaHanSansNeo(ofSize: 18, weight: .regular)
    ]
    private let emphasisAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white ,
        .font: UIFont.spoqaHanSansNeo(ofSize: 18, weight: .medium)
    ]
    private let underLineAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.white ,
        .font: UIFont.spoqaHanSansNeo(ofSize: 18, weight: .medium),
        .underlineStyle: 1
    ]
    private let accountNameAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.dandelion,
        .font: UIFont.spoqaHanSansNeo(ofSize: 18, weight: .regular)
    ]
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        accountLabelTapGesture()
        self.view.backgroundColor = .backgroundColor
        view.setNeedsUpdateConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func updateViewConstraints() {
        self.view.addSubviews([verticalStackView, closeButton])
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(44)
        }
        verticalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    @objc
    private func closeBtn() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    @objc
    private func copyAccount() {
        UIPasteboard.general.string = self.account + self.bankName
        print("✨ copy 완료 \(self.account) \(self.bankName)")
    }
    
    // MARK: - Methods
    private func accountLabelTapGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(copyAccount))
        accountLabel.isUserInteractionEnabled = true
        accountLabel.addGestureRecognizer(tapGesture)
    }
}
