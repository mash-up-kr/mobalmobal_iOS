//
//  InputChargingPointViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/03/05.
//

import SnapKit
import UIKit

class InputChargingPointViewController: UIViewController {
    // MARK: - UIComponents
    private let chargingInputView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = UIColor(cgColor: CGColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.07))
        return view
    }()
    private let chargingInputField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "충전할 금액을 입력하세요."
        textField.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        textField.textColor = UIColor(cgColor: (CGColor(red: 121.0 / 255.0, green: 121.0 / 255.0, blue: 121.0 / 255.0, alpha: 1.0)))
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
        button.backgroundColor = UIColor(cgColor: CGColor(red: 71.0 / 255.0, green: 71.0 / 255.0, blue: 71.0 / 255.0, alpha: 1))
        
        button.setTitle("충전하기", for: .normal)
        button.setTitleColor(UIColor(cgColor: (CGColor(red: 121.0 / 255.0, green: 121.0 / 255.0, blue: 121.0 / 255.0, alpha: 1.0))), for: .normal)
        return button
    }()
    private let navBar: UINavigationBar = {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width, height: 88))
        navBar.barTintColor = .black94
        navBar.isTranslucent = false
        let navItem: UINavigationItem = UINavigationItem(title: "충전")
        let beforeItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrowChevronBigLeft"), style: .plain, target: nil, action: #selector(popVC))
        navBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        beforeItem.tintColor = .white
        navItem.leftBarButtonItem = beforeItem
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.navigationController?.title = "충전"
        setLayout()
    }
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("✨")
        self.navBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 88)
    }
    
    private func setLayout() {
        print("✨ set layout")
        [chargingInputView, chargingButton, navBar].forEach { view.addSubview($0) }
        [chargingViewImage, chargingInputField].forEach { chargingInputView.addSubview($0) }
        chargingInputView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(52)
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
    
    @objc private func popVC() {
        print("✨ pop viewcontroller")
    }
}
