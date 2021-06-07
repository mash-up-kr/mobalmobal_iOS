//
//  MyAccountViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/05/01.
//

import SnapKit
import UIKit

class MyAccountViewController: UIViewController {
    
    // MARK: - UIComponents
    private let bankNameInputView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .white7
        return view
    }()
    private let bankNameInputTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.font = .spoqaHanSansNeo(ofSize: 15, weight: .bold)
        textField.attributedPlaceholder = NSAttributedString(string: "은행을 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.brownGreyTwo])
        textField.textColor = .white
        textField.addTarget(self, action: #selector(bankNametextEdited(textField:)), for: .editingChanged)
        return textField
    }()
    private let bankNameImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "iconlyBank")
        imageView.layer.shadowRadius = 1.8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 3.6)
        imageView.layer.shadowColor = UIColor.lightBluishGreen.cgColor
        return imageView
    }()
    private let accountNumberInputView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .white7
        return view
    }()
    private let accountNumberInputTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.font = .spoqaHanSansNeo(ofSize: 15, weight: .bold)
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "계좌 번호를 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.brownGreyTwo])
        textField.textColor = .white
        textField.addTarget(self, action: #selector(accountNumbertextEdited(textField:)), for: .editingChanged)
        return textField
    }()
    private let accountNumberImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "iconlyBankAccoun")
        imageView.layer.shadowRadius = 1.8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 3.6)
        imageView.layer.shadowColor = UIColor.lightBluishGreen.cgColor
        return imageView
    }()
    private let saveButton: UIButton = {
        let button: UIButton = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .greyishBrown
        button.setTitle("저장하기", for: .normal)
        button.titleLabel?.font = .spoqaHanSansNeo(ofSize: 18, weight: .medium)
        button.setTitleColor(.brownGreyTwo, for: .normal)
        button.addTarget(self, action: #selector(saveBtnAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private let myAccountViewModel: MyAccountViewModel = MyAccountViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.bankNameInputTextField.becomeFirstResponder()
        viewTapGesture()
        setNavigationItems()
        setLayout()
        initAPICall()
        myAccountViewModel.delegate = self
    }
    
    // MARK: - Actions
    @objc
    private func bankNametextEdited(textField: UITextField) {
        disactivateButtonUI()
        if accountNumberInputTextField.text != "" && textField.text != "" { activateButtonUI() }
    }
    @objc
    private func accountNumbertextEdited(textField: UITextField) {
        disactivateButtonUI()
        if bankNameInputTextField.text != "" && textField.text != "" { activateButtonUI() }
    }
    @objc
    private func saveBtnAction() {
        myAccountViewModel.bankName = bankNameInputTextField.text
        myAccountViewModel.accountName = accountNumberInputTextField.text
        myAccountViewModel.patchMyAccount()
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Methods
    private func initAPICall() {
        myAccountViewModel.getMyProfile { [weak self] success in
            if success {
                if let bankName = self?.myAccountViewModel.getBankName,
                   let accountNumber = self?.myAccountViewModel.getAccountName {
                    self?.bankNameInputTextField.text = bankName
                    self?.accountNumberInputTextField.text = accountNumber
                    self?.activateButtonUI()
                }
            }
        }
    }
    private func viewTapGesture() {
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    private func activateButtonUI() {
        saveButton.setTitleColor(.blackThree, for: .normal)
        saveButton.backgroundColor = .lightBluishGreen
        saveButton.isEnabled = true
    }
    private func disactivateButtonUI() {
        saveButton.setTitleColor(.brownGreyTwo, for: .normal)
        saveButton.backgroundColor = .greyishBrown
        saveButton.isEnabled = false
    }
    private func setNavigationItems() {
        self.setNavigationItems(title: "내 계좌", backButtonImageName: "arrowChevronBigLeft", action: #selector(popVC))
    }
    private func setLayout() {
        [saveButton, bankNameInputView, accountNumberInputView].forEach { view.addSubview($0) }
        [bankNameImage, bankNameInputTextField].forEach { bankNameInputView.addSubview($0) }
        [accountNumberImage, accountNumberInputTextField].forEach { accountNumberInputView.addSubview($0) }
        bankNameInputView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(60)
        }
        accountNumberInputView.snp.makeConstraints { make in
            make.top.equalTo(bankNameInputView.snp.bottom).offset(17)
            make.leading.trailing.equalTo(bankNameInputView)
            make.height.equalTo(60)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(accountNumberInputView.snp.bottom).offset(43)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(196)
        }
        bankNameImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.size.equalTo(44)
        }
        bankNameInputTextField.snp.makeConstraints { make in
            make.leading.equalTo(bankNameImage.snp.trailing).offset(17)
            make.trailing.equalToSuperview().inset(17)
            make.top.bottom.equalToSuperview().inset(21)
        }
        accountNumberImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.size.equalTo(44)
        }
        accountNumberInputTextField.snp.makeConstraints { make in
            make.leading.equalTo(accountNumberImage.snp.trailing).offset(17)
            make.trailing.equalToSuperview().inset(17)
            make.top.bottom.equalToSuperview().inset(21)
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MyAccountViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

// MARK: - MyAccountViewModelDelegate
extension MyAccountViewController: MyAccountViewModelDeleagte {
    func networkErr() {
        let netWorkVC: NetworkErrorViewController = NetworkErrorViewController()
        self.present(netWorkVC, animated: true) { [weak self] in
            self?.myAccountViewModel.patchMyAccount()
        }
    }
}
