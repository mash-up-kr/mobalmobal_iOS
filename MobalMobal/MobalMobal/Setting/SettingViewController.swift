//
//  SettingViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/27.
//

import SnapKit
import UIKit
import WebKit

class SettingViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
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
    private lazy var webView: WKWebView = {
        let webView: WKWebView = WKWebView()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    // MARK: - Property
    let webVC: WebviewController = WebviewController()
    // MARK: - Actions
    private var webView1: WKWebView?
    @objc
    func openSourceAction() {
        self.navigationController?.showDetailViewController(webVC, sender: self)
    }
    @objc
    func termsAndConditionAction() {
        self.navigationController?.showDetailViewController(webVC, sender: self)
    }
    @objc
    func inquiryAction() {
        self.present(webVC, animated: true) {
            
        }
    }
    
    // MARK: - Method
    private func setURLRequest(to url: String) -> URLRequest? {
        guard let url: URL = URL(string: "https://www.naver.com") else { return nil }
        let request: URLRequest = URLRequest(url: url)
        return request
    }
    private func setup() {
        self.view.backgroundColor = .backgroundColor
        self.setNavigationController()
        self.view.addSubviews([myAccountLabel, openSourceLabel, termsAndConditionLabel, alarmLabel, alarmSwitch, inquiryLabel])
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
}
