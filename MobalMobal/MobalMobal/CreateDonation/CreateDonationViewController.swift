//
//  CreateDonationViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/03/27.
//

import SnapKit
import UIKit

class CreateDonationViewController: UIViewController, UINavigationControllerDelegate {
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
    
    private let donationEndDateView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private let photoView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .darkGreyThree
        return view
    }()
    
    private let photoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let cameraImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "iconlyLightCamera")
        return imageView
    }()
    
    private let photoButton: UIButton = {
        let button: UIButton = UIButton()
        button.addTarget(self, action: #selector(photoButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    @objc
    func photoButtonIsTapped() {
        let pickerController: UIImagePickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
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
    
    private var donationEndDateTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "종료 날짜를 선택해주세요", attributes: [
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
    
    private let dividerView5: UIView = {
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
        donationEndDateTextField.delegate = self
        
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
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "ko_KR")
        donationStartDateTextField.inputView = datePicker
        donationEndDateTextField.inputView = datePicker
        
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
        } else if donationEndDateTextField.isEditing {
            donationEndDateTextField.text = datePickerDate
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
    
    private func donationStartDateViewIsFileld() {
        self.view.addSubview(donationEndDateView)
        donationEndDateView.snp.makeConstraints { make in
            make.top.equalTo(createDonationLabel.snp.bottom).offset(177)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(49)
        }
        
        self.donationEndDateView.addSubview(donationEndDateTextField)
        donationEndDateTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(donationEndDateView)
        }
        
        self.donationEndDateView.addSubview(dividerView5)
        dividerView5.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(donationEndDateView)
            make.height.equalTo(1)
        }
        
        resetConstraint(baseView: self.donationStartDateView, offset: 263)
        resetConstraint(baseView: self.donationPriceView, offset: 349)
        resetConstraint(baseView: self.donationInputView, offset: 435)
        resetConstraint(baseView: self.donationProductView, offset: 521)
    }
    
    private func donationEndDateViewIsFilled() {
        self.view.addSubview(photoView)
        photoView.snp.makeConstraints { make in
            make.top.equalTo(createDonationLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(218)
        }
        
        photoView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        photoView.addSubview(cameraImageView)
        cameraImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
    
        photoView.addSubview(photoButton)
        photoButton.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func resetConstraint(baseView: UIView, offset: Int) {
        let createDonationLabelBottom: CGFloat = 58
        
        baseView.snp.removeConstraints()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            baseView.snp.makeConstraints { make in
                let tranform: CGAffineTransform = CGAffineTransform(translationX: 0, y: createDonationLabelBottom + CGFloat(offset))
                make.leading.trailing.equalToSuperview().inset(28)
                make.height.equalTo(49)
                baseView.transform = tranform
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
            dontationTextFieldIsFilled()
        } else if donationTextField.isEditing && !(donationTextField.text?.isEmpty ?? false) {
            donationInputViewIsFilled()
        } else if donationPriceTextField.isEditing && !(donationPriceTextField.text?.isEmpty ?? false) {
            donationPriceViewIsFilled()
        } else if donationStartDateTextField.isEditing && !(donationStartDateTextField.text?.isEmpty ?? false) {
            donationStartDateViewIsFileld()
        } else if donationEndDateTextField.isEditing && !(donationEndDateTextField.text?.isEmpty ?? false) {
            donationEndDateViewIsFilled()
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
        } else if textField == donationStartDateTextField {
            guard !(donationStartDateTextField.text?.isEmpty ?? false) else {
                return false
            }
            donationStartDateViewIsFileld()
        } else if textField == donationEndDateTextField {
            guard !(donationEndDateTextField.text?.isEmpty ?? false) else {
                return false
            }
            donationEndDateViewIsFilled()
        }
        
        self.view.endEditing(true)
        
        return true
    }
}

// MAKR: - UIImaePickerControlllerDelegate
extension CreateDonationViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage: UIImage = info[.originalImage] as? UIImage {
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.image = selectedImage
            photoButton.backgroundColor = .clear
            cameraImageView.isHidden = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}


