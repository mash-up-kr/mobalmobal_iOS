//
//  SettingViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/27.
//

import SnapKit
import UIKit

class SettingViewController: UIViewController {
    // MARK: - UIView
    private let myAccountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "내 계좌"
        return label
    }()
    
    private let openSourceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "오픈소스 약관"
        return label
    }()
    
    private let termsAndConditionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "이용약관"
        return label
    }()
    
    private let alarmLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "알림"
        return label
    }()
    
    private let alarmSwitch: UISwitch = {
        let alarmSwitch: UISwitch = UISwitch()
        alarmSwitch.onTintColor = .barbiePink
        return alarmSwitch
    }()
    
    private let inquiryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "문의하기"
        return label
    }()
    
    // MARK: - Property
    
    // MARK: - Method
    private func setup() {
        self.view.backgroundColor = .backgroundColor
        self.setNavigationController()
        self.view.addSubviews([myAccountLabel, openSourceLabel, termsAndConditionLabel, alarmLabel, alarmSwitch, inquiryLabel])
        self.setConstraint()
    }
    
    private func setNavigationController() {
        self.title = "설정"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .black94
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrowChevronBigLeft"), style: .done, target: self, action: #selector(barButtonTapped))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc
    func barButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setConstraint() {
        myAccountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview().offset(21)
        }
        
        openSourceLabel.snp.makeConstraints { make in
            make.top.equalTo(myAccountLabel.snp.bottom).offset(31)
            make.leading.equalTo(myAccountLabel)
        }
        
        termsAndConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(openSourceLabel.snp.bottom).offset(31)
            make.leading.equalTo(openSourceLabel)
        }
        
        alarmLabel.snp.makeConstraints { make in
            make.top.equalTo(termsAndConditionLabel.snp.bottom).offset(31)
            make.leading.equalTo(termsAndConditionLabel)
        }
        
        alarmSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(alarmLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        inquiryLabel.snp.makeConstraints { make in
            make.top.equalTo(alarmLabel.snp.bottom).offset(31)
            make.leading.equalTo(alarmLabel)
        }
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

