//
//  InputDonationMoneyViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/12.
//
import SnapKit
import UIKit

class InputDonationMoneyViewController: UIViewController {
    // MARK: - UIComponents
    private let roundView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .white7
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        guard let image: UIImage = UIImage(named: iconImageName) else {
            imageView.backgroundColor = .white
            return imageView
        }
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textField: UITextField = {
        let textField: UITextField = UITextField()
        textField.font = .spoqaHanSansNeo(ofSize: 15, weight: .bold)
        textField.textColor = .white
        textField.placeholder = placeholderString
        textField.setPlaceholderColor(.brownGreyTwo)
        
        textField.keyboardType = .numberPad
        textField.keyboardAppearance = .dark
        return textField
    }()
    
    private lazy var donationButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle(buttonString, for: .normal)
        button.titleLabel?.font = .spoqaHanSansNeo(ofSize: 18, weight: .medium)
                
        button.setTitleColor(.blackThree, for: .normal)
        button.setTitleColor(.brownGreyTwo, for: .disabled)
        return button
    }()
    
    // MARK: - Properties
    private let navigationTitle: String = "후원"
    private let iconImageName: String = "iconlyBrokenBuy"
    private let placeholderString: String = "후원할 금액을 입력하세요."
    private let buttonString: String = "후원하기"
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setButtonDisable()
    }
    
    override func updateViewConstraints() {
        view.addSubviews([roundView, donationButton])
        setRoundViewConstraints()
        setButtonConstraints()
        
        roundView.addSubviews([iconImageView, textField])
        setIconImageViewConstraints()
        setTextFieldConstraints()
        super.updateViewConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        roundView.roundCorner()
        donationButton.roundCorner()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          dismissKeyboard()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    private func setRoundViewConstraints() {
        roundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height * 52 / 812)
            make.leading.equalToSuperview().inset(view.frame.width * 15 / 375 )
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    private func setButtonConstraints() {
        donationButton.snp.makeConstraints { make in
            make.top.equalTo(roundView.snp.bottom).offset(43)
            make.centerX.equalToSuperview()
            make.width.equalTo(196)
            make.height.equalTo(60)
        }
    }
    private func setIconImageViewConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(44)
        }
    }
    private func setTextFieldConstraints() {
        textField.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(17)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setButtonEnable() {
        donationButton.isEnabled = true
        donationButton.backgroundColor = .lightBluishGreen
    }
    
    private func setButtonDisable() {
        donationButton.isEnabled = false
        donationButton.backgroundColor = .greyishBrown
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}
