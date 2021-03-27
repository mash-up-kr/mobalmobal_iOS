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
        
        textField.delegate = self
        return textField
    }()
    
    private lazy var donationButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle(buttonString, for: .normal)
        button.titleLabel?.font = .spoqaHanSansNeo(ofSize: 18, weight: .medium)
                
        button.setTitleColor(.blackThree, for: .normal)
        button.setTitleColor(.brownGreyTwo, for: .disabled)
        
        button.addTarget(self, action: #selector(clickDonationButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private let navigationTitle: String = "후원"
    private let backButtonImageName: String = "arrowChevronBigLeft"
    private let iconImageName: String = "iconlyBrokenBuy"
    private let placeholderString: String = "후원할 금액을 입력하세요."
    private let buttonString: String = "후원하기"
    
    private let maxMoneyRange: Int = 10_000_000
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setNavigationItems()
        setButtonDisable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
    @objc
    private func clickDonationButton() {
        print("🐻 \(textField.text!)원 후원하기 🐻")
    }
    @objc
    private func clickNavigationBackButton() {
        dismissNavigationController()
    }
    
    // MARK: - Methods
    private func setNavigationItems() {
        setNavigationItems(title: navigationTitle, backButtonImageName: backButtonImageName, action: #selector(clickNavigationBackButton))
    }
    
    private func setRoundViewConstraints() {
        roundView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(view.frame.height * 52 / 812)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(view.frame.width * 15 / 375 )
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
    
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func isOverMaxRange(_ string: String) -> Bool {
        if let number: Int = Int(string), number > maxMoneyRange {
            return true
        }
        return false
    }
    
    private func checkEmptyOrZero(_ string: String) {
        if string.isEmpty {
            setButtonDisable()
        } else if Int(string) == 0 {
            setButtonDisable()
        } else {
            setButtonEnable()
        }
    }
    
    private func showAlert() {
        let alert: UIAlertController = UIAlertController(title: "후원 금액", message: "최대 후원 금액은 10,000,000원 입니다.", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    @objc
    private func dismissNavigationController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension InputDonationMoneyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 기존 문자열 (콤마 없는)
        let rawString: String = makeRawString(from: textField.text)
        
        if Int(string) == nil {
            // 새로운 입력값 == 백스페이스
            if string.isEmpty {
                let newRawString: String = backspace(from: rawString)
                checkEmptyOrZero(newRawString)
                
                if let formattedString: String = makeFormattedString(from: newRawString) {
                    textField.text = formattedString
                    return false
                }
                return true
            }
            // 새로운 입력값 == 문자
            return false
        }
        
        // 새로 만들어질 문자열 (콤마 없는)
        let newRawString: String = rawString + string
        checkEmptyOrZero(newRawString)
        
        if isOverMaxRange(newRawString) {
            dismissKeyboard()
            textField.text = "10,000,000"
            showAlert()
            return false
        }
        
        if let formattedString: String = makeFormattedString(from: newRawString) {
            textField.text = formattedString
            return false
        }
        
        return true
    }
    
    private func backspace(from string: String) -> String {
        if string.count < 2 { return "" }
        
        let firstIndex: String.Index = string.startIndex
        let lastIndex: String.Index = string.index(before: string.endIndex)
        return String(string[firstIndex..<lastIndex])
    }
    
    private func makeRawString(from string: String?) -> String {
        string?.replacingOccurrences(of: ",", with: "") ?? ""
    }
    
    private func makeFormattedString(from rawString: String) -> String? {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        guard let formattedNumber: NSNumber = formatter.number(from: rawString), let formattedString: String = formatter.string(from: formattedNumber) else {
            return nil
        }
        return formattedString
    }
}
