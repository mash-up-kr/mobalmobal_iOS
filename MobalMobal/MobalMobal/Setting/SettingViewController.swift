//
//  SettingViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/27.
//

import SnapKit
import UIKit
import WebKit

enum SettingURL: String {
    case openSource = "https://www.notion.so/b384c72d60cc4475af49284625f81a0e"
    case termsAndConditioin = "https://www.notion.so/26c36382cd8448188c7532519b9019cc"
    case openKakaoTalk = "https://open.kakao.com/o/sRo0Df7c"
}

class SettingViewController: DoneBaseViewController {
    // MARK: - UIView
    private let myAccountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "내 계좌"
        return label
    }()
    private let myAccountButton: UIButton = {
        let button: UIButton = UIButton()
        button.addTarget(self, action: #selector(myAccountAction), for: .touchUpInside)
        return button
    }()
    private let openSourceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "오픈소스 약관"
        return label
    }()
    private let openSourceButton: UIButton = {
        let button: UIButton = UIButton()
        button.addTarget(self, action: #selector(openSourceAction), for: .touchUpInside)
        return button
    }()
    private let termsAndConditionLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "이용약관"
        return label
    }()
    private let termsAndConditionButton: UIButton = {
        let button: UIButton = UIButton()
        button.addTarget(self, action: #selector(termsAndConditionAction), for: .touchUpInside)
        return button
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
    private let inquiryButton: UIButton = {
        let button: UIButton = UIButton()
        button.addTarget(self, action: #selector(inquiryAction), for: .touchUpInside)
        return button
    }()

    // MARK: - Actions
    @objc
    func myAccountAction() {
        let alertController: UIAlertController = UIAlertController(title: "내 계좌", message: "신한1010101010", preferredStyle: .alert)
        let okBtn: UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okBtn)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc
    func openSourceAction() {
        let webVC: WebviewController = WebviewController()
        webVC.webURL = SettingURL.openSource.rawValue
        webVC.navTitle = "오픈소스 약관"
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    @objc
    func termsAndConditionAction() {
        let webVC: WebviewController = WebviewController()
        webVC.webURL = SettingURL.termsAndConditioin.rawValue
        webVC.navTitle = "이용약관"
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    @objc
    func inquiryAction() {
        let webVC: WebviewController = WebviewController()
        webVC.webURL = SettingURL.openKakaoTalk.rawValue
        webVC.navTitle = "문의하기"
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    // MARK: - Method

    private func setup() {
        self.view.backgroundColor = .backgroundColor
        self.setNavigationController()
        self.view.addSubviews([myAccountLabel, openSourceLabel, termsAndConditionLabel, inquiryLabel])
        self.view.addSubviews([myAccountButton, openSourceButton, termsAndConditionButton, inquiryButton])
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
    private func barButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setConstraint() {
        myAccountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview().offset(21)
        }
        myAccountButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(myAccountLabel)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        openSourceLabel.snp.makeConstraints { make in
            make.top.equalTo(myAccountLabel.snp.bottom).offset(31)
            make.leading.equalTo(myAccountLabel)
        }
        openSourceButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(openSourceLabel)
            make.leading.trailing.equalTo(myAccountButton)
        }
        termsAndConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(openSourceLabel.snp.bottom).offset(31)
            make.leading.equalTo(openSourceLabel)
        }
        termsAndConditionButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(termsAndConditionLabel)
            make.leading.trailing.equalTo(openSourceButton)
        }
        // 1차 배포 제외 대상 (알람설정)
//        alarmLabel.snp.makeConstraints { make in
//            make.top.equalTo(termsAndConditionLabel.snp.bottom).offset(31)
//            make.leading.equalTo(termsAndConditionLabel)
//        }
        
//        alarmSwitch.snp.makeConstraints { make in
//            make.centerY.equalTo(alarmLabel)
//            make.trailing.equalToSuperview().inset(20)
//        }
//
        inquiryLabel.snp.makeConstraints { make in
            make.top.equalTo(termsAndConditionLabel.snp.bottom).offset(31)
            make.leading.equalTo(termsAndConditionLabel)
        }
        inquiryButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(inquiryLabel)
            make.leading.trailing.equalTo(termsAndConditionButton)
        }
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
