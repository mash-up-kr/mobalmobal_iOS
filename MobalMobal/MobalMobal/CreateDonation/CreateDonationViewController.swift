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
    
    private let datePicker: UIDatePicker = UIDatePicker()
    
    private let donationProductView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private let donationInputView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private let donationPriceView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private let donationStartDateView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private var donataionProductTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "가지고 싶은 물건 이름은?", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.veryLightPink,
//            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 24)
        ])
        textField.font = UIFont(name: "Roboto-Regular", size: 24)
        textField.textColor = .veryLightPink
        return textField
    }()
    
    private var donationTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "하고싶은 말", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.veryLightPink,
//            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 24)
        ])
        textField.font = UIFont(name: "Roboto-Regular", size: 24)
        textField.textColor = .veryLightPink
        return textField
    }()
    
    private var donationPriceTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "얼마를 모아볼까요?", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.veryLightPink,
//            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 24)
        ])
        textField.font = UIFont(name: "Roboto-Regular", size: 24)
        textField.textColor = .veryLightPink
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private var donationStartDateTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "시작 날짜를 선택해주세요", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.veryLightPink,
//            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 24)
        ])
        textField.font = UIFont(name: "Roboto-Regular", size: 24)
        textField.textColor = .veryLightPink
        
        return textField
    }()
    
    private let dividerView1: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .wheat
        view.layer.shadowColor = UIColor.lemonLime80.cgColor
        view.layer.shadowRadius = 10
        return view
    }()
    
    private let dividerView2: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .wheat
        view.layer.shadowColor = UIColor.lemonLime80.cgColor
        view.layer.shadowRadius = 10
        return view
    }()
    
    private let dividerView3: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .wheat
        view.layer.shadowColor = UIColor.lemonLime80.cgColor
        view.layer.shadowRadius = 10
        return view
    }()
    
    private let dividerView4: UIView = {
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
        donationTextField.delegate = self
        donationPriceTextField.delegate = self
        donataionProductTextField.delegate = self
        donationStartDateTextField.delegate = self
        
        addTapGesture(to: view)
        
        setBasicViewLayout()
        setDonationProductView()
        setDatePicker()
    }
    
    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setDatePicker() {
        let dateFormatter: DateFormatter = DateFormatter()
        let minho = dateFormatter.dateFormat = "YYYY-MM-DD hh:mm"
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "ko_KR")
        donationStartDateTextField.inputView = datePicker
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.addTarget(self, action: #selector(updateTextField), for: .valueChanged)
        
        datePicker.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
    
    @objc
    func updateTextField() {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD hh:mm"
        let datePickerDate: String = dateFormatter.string(from: datePicker.date)
        
        if donationStartDateTextField.isEditing {
            donationStartDateTextField.text = datePickerDate
        }
    }
    
    private func setBasicViewLayout() {
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
    
    private func setDonationProductView() {
        self.view.addSubview(donationProductView)
        donationProductView.snp.makeConstraints { make in
            make.top.equalTo(createDonationLabel.snp.bottom).offset(177)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(49)
        }
        
        self.donationProductView.addSubview(donataionProductTextField)
        donataionProductTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(donationProductView)
        }
        
        self.donationProductView.addSubview(dividerView1)
        dividerView1.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(donationProductView)
            make.height.equalTo(1)
        }
    }
    
    private func dontationTextFieldIsFilled() {
        self.view.addSubview(donationInputView)
        donationInputView.snp.makeConstraints { make in
            make.top.equalTo(createDonationLabel.snp.bottom).offset(177)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(49)
        }

        self.donationInputView.addSubview(donationTextField)
        donationTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(donationInputView)
        }

        self.donationInputView.addSubview(dividerView2)
        dividerView2.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(donationInputView)
            make.height.equalTo(1)
        }

        resetConstraint(baseView: self.donationProductView, offset: 263)
    }
    
    private func donationInputViewIsFilled() {
        self.view.addSubview(donationPriceView)
        donationPriceView.snp.makeConstraints { make in
            make.top.equalTo(createDonationLabel.snp.bottom).offset(177)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(49)
        }
        
        self.donationPriceView.addSubview(donationPriceTextField)
        donationPriceTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(donationPriceView)
        }
        
        self.donationPriceView.addSubview(dividerView3)
        dividerView3.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(donationPriceView)
            make.height.equalTo(1)
        }
    
        resetConstraint(baseView: self.donationProductView, offset: 349)
        resetConstraint(baseView: self.donationInputView, offset: 263)
    }
    
    private func donationPriceViewIsFilled() {
        self.view.addSubview(donationStartDateView)
        donationStartDateView.snp.makeConstraints { make in
            make.top.equalTo(createDonationLabel.snp.bottom).offset(177)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(49)
        }
        
        self.donationStartDateView.addSubview(donationStartDateTextField)
        donationStartDateTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(donationStartDateView)
        }
        
        self.donationStartDateView.addSubview(dividerView4)
        dividerView4.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(donationStartDateView)
            make.height.equalTo(1)
        }
        
        resetConstraint(baseView: self.donationPriceView, offset: 263)
        resetConstraint(baseView: self.donationInputView, offset: 349)
        resetConstraint(baseView: self.donationProductView, offset: 435)
    }
    
    private func resetConstraint(baseView: UIView, offset: Int) {
        baseView.snp.removeConstraints()
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn) {
            baseView.snp.makeConstraints { make in
                make.top.equalTo(self.createDonationLabel.snp.bottom).offset(offset)
                make.leading.trailing.equalToSuperview().inset(28)
                make.height.equalTo(49)
//                baseView.layoutIfNeeded()
            }
        }
    }
    
    private func addTapGesture(to view: UIView) {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func dismissButtonIsTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func dismissKeyboard() {
        if donataionProductTextField.isEditing && !(donataionProductTextField.text?.isEmpty ?? false) {
            print("1")
            dontationTextFieldIsFilled()
        } else if donationTextField.isEditing && !(donationTextField.text?.isEmpty ?? false) {
            print("2")
            donationInputViewIsFilled()
        } else if donationPriceTextField.isEditing && !(donationPriceTextField.text?.isEmpty ?? false) {
            print("3")
            donationPriceViewIsFilled()
        }
        view.endEditing(true)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

    
    }
}

// MARK: - UITextFieldDelegate
extension CreateDonationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == donataionProductTextField {
            guard !(donataionProductTextField.text?.isEmpty ?? false) else {
                return false
            }
            dontationTextFieldIsFilled()
        } else if textField == donationTextField {
            guard !(donationTextField.text?.isEmpty ?? false) else {
                return false
            }
            donationInputViewIsFilled()
        } else if textField == donationPriceTextField {
            guard !(donationPriceTextField.text?.isEmpty ?? false) else {
                return false
            }
            donationPriceViewIsFilled()
        }
        
        self.view.endEditing(true)
        
        return true
    }
}