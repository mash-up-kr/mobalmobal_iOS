//
//  CreateDonationViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/03/27.
//

import SnapKit
import UIKit

class CreateDonationViewController: UIViewController {
    // MARK: - UIView
    let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.backgroundColor = .backgroundColor
        return scrollView
    }()
    
    private let createDonationLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "Roboto-Bold", size: 15)
        label.text = "도네이션 생성"
        label.textColor = .white
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "menuCloseBig"), for: .normal)
        button.addTarget(self, action: #selector(dismissButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    private var donationStuffTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "가지고 싶은 물건 이름은?", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.veryLightPink,
//            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 24)
        ])
        textField.font = UIFont(name: "Roboto-Regular", size: 24)
        textField.textColor = .veryLightPink
        return textField
    }()
    
    private let dividerView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .wheat
        view.layer.shadowColor = UIColor.lemonLime80.cgColor
        view.layer.shadowRadius = 10
        return view
    }()
    
    // MARK: - Method
    private func setup() {
        self.view.backgroundColor = .backgroundColor
        setScrollView()
        addTapGesture(to: view)
    }
    
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setViewLayout() {
        self.view.addSubview(createDonationLabel)
        createDonationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(18)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(0)
            make.trailing.equalToSuperview().inset(8)
        }
        
        self.view.addSubview(donationStuffTextField)
        donationStuffTextField.snp.makeConstraints { make in
            make.top.equalTo(createDonationLabel.snp.bottom).offset(177)
            make.leading.equalToSuperview().inset(28)
            make.trailing.equalToSuperview().inset(97)
        }
        
        self.view.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(donationStuffTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(1)
        }
    }
    
    private func addTapGesture(to view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func dismissButtonIsTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setViewLayout()
    }
}
