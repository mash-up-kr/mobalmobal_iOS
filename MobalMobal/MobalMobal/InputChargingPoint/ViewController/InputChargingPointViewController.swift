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
        view.backgroundColor = .white7
        return view
    }()
    private let chargingInputField: UITextField = {
        let textField: UITextField = UITextField()
        textField.font = .spoqaHanSansNeo(ofSize: 15, weight: .bold)
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "충전할 금액을 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.brownGreyTwo])
        textField.textColor = .white
        textField.addTarget(self, action: #selector(textEdited), for: .editingChanged)
        return textField
    }()
    private let chargingViewImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "iconlyBrokenBuy")
        imageView.layer.shadowRadius = 1.8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 3.6)
        imageView.layer.shadowColor = UIColor.lightBluishGreen.cgColor
        return imageView
    }()
    private let chargingButton: UIButton = {
        let button: UIButton = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .greyishBrown
        button.setTitle("충전하기", for: .normal)
        button.titleLabel?.font = .spoqaHanSansNeo(ofSize: 18, weight: .medium)
        button.setTitleColor(.brownGreyTwo, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - Properties
    private let numberFormat: (Int) -> String = { number in
        let str: String = "\(number)"
        let regex: NSRegularExpression?
        do {
            regex = try? NSRegularExpression(pattern: "(?<=\\d)(?=(?:\\d{3})+(?!\\d))", options: [])
        }
        guard let regexString = regex else { return "" }
        return regexString.stringByReplacingMatches(in: str,
                                                    options: [],
                                                    range: NSRange(location: 0, length: str.count),
                                                    withTemplate: ",")
    }
    private let maxChargingPoint: Int = 10_000_000
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.chargingInputField.becomeFirstResponder()
        viewTapGesture()
        setNavigationItems()
        setLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Actions
    @objc
    private func buttonTapped() {
        let accountVC: AccountViewController = AccountViewController()
        guard let inputText = chargingInputField.text else {
            return
        }
        accountVC.charge = "\(inputText)원"
        self.navigationController?.pushViewController(accountVC, animated: true)
        //여기서 서버에 얼만큼 요청했는지 보내줘야한다.
    }
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    private func textEdited(textField: UITextField) {
        guard var textFieldText = textField.text else { return }
        if !textFieldText.isEmpty {
            textFieldText = textFieldText.replacingOccurrences(of: ",", with: "")
            let chargingPointInt: Int = Int(String(textFieldText))!
            if chargingPointInt > maxChargingPoint {
                chargingInputField.text = ""
                showAlertController()
                disactivateButtonUI()
            } else {
                chargingInputField.text = numberFormat(chargingPointInt)
                activateButtonUI()
            }
        } else {
            // 텍스트가 backspace로 다 지워져서 isEmpty한 경우
            disactivateButtonUI()
        }
    }
    
    // MARK: - Methods
    private func viewTapGesture() {
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    private func activateButtonUI() {
        chargingButton.setTitleColor(.blackThree, for: .normal)
        chargingButton.backgroundColor = .lightBluishGreen
        chargingButton.isEnabled = true
    }
    private func disactivateButtonUI() {
        chargingButton.setTitleColor(.brownGreyTwo, for: .normal)
        chargingButton.backgroundColor = .greyishBrown
        chargingButton.isEnabled = false
    }
    private func showAlertController() {
        // TODO
        // 디자인 나오면 수정 필요
        let alertController: UIAlertController = UIAlertController(title: "충전금액", message: "충전가능금액은 최대 10,000,000원 입니다.", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    private func setNavigationItems() {
        self.setNavigationItems(title: "충전", backButtonImageName: "arrowChevronBigLeft", action: #selector(popVC))
    }
    private func setLayout() {
        [chargingButton, chargingInputView].forEach { view.addSubview($0) }
        [chargingViewImage, chargingInputField].forEach { chargingInputView.addSubview($0) }
        chargingInputView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(52)
            make.leading.trailing.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        chargingButton.snp.makeConstraints { make in
            make.top.equalTo(chargingInputView.snp.bottom).offset(43)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(196)
        }
        chargingViewImage.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.size.equalTo(44)
        }
        chargingInputField.snp.makeConstraints { make in
            make.leading.equalTo(chargingViewImage.snp.trailing).offset(17)
            make.trailing.equalToSuperview().inset(17)
            make.top.bottom.equalToSuperview().inset(21)
        }
    }
}
// MARK: - UIGestureRecognizerDelegate
extension InputChargingPointViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
