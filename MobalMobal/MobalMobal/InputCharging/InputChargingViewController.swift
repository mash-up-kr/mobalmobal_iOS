//
//  InputChargingViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/03/02.
//

import SnapKit
import UIKit

class InputChargingViewController: UIViewController {
    // MARK: - UIComponents
    private let chargingInputView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = UIColor(cgColor: CGColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.7))
        return view
    }()
    private let chargingInputField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "충전할 금액을 입력하세요."
        textField.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        textField.textColor = UIColor(cgColor: (CGColor(red: 121/255.0, green: 121/255.0, blue: 121/255.0, alpha: 1.0)))
        textField.keyboardType = .numberPad
        return textField
    }()
    private let chargingViewImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "iconlyBrokenBuy")
        imageView.layer.shadowRadius = 1.7
        imageView.layer.shadowColor = UIColor.lightBluishGreen.cgColor
        return imageView
    }()
    private let chargingButton: UIButton = {
        let button: UIButton = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor(cgColor: CGColor(red: 71/255.0, green: 71/255.0, blue: 71/255.0, alpha: 1))
        
        button.setTitle("충전하기", for: .normal)
        button.setTitleColor(UIColor(cgColor: (CGColor(red: 121/255.0, green: 121/255.0, blue: 121/255.0, alpha: 1.0))), for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.navigationController?.title = "충전"
        setLayout()
    }
    
    private func setLayout() {
        print("✨ set layout")
        [chargingInputView, chargingButton].forEach { view.addSubview($0) }
        [chargingViewImage, chargingInputField].forEach { chargingInputView.addSubview($0) }
        chargingInputView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(345)
        }
        chargingButton.snp.makeConstraints { make in
            make.top.equalTo(chargingInputView.snp.bottom).offset(43)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(196)
        }
        chargingViewImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.height.width.equalTo(44)
        }
        chargingInputField.snp.makeConstraints { make in
            make.leading.equalTo(chargingViewImage.snp.trailing).offset(17)
            make.trailing.greaterThanOrEqualToSuperview().inset(113)
            make.top.bottom.equalToSuperview().inset(21)
        }
    }
}
