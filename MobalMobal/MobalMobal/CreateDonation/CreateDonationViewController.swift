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
    
    // MARK: - Method
    private func setup() {
        self.view.backgroundColor = .backgroundColor
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
    }
    
    @objc
    private func dismissButtonIsTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setViewLayout()
    }
}
