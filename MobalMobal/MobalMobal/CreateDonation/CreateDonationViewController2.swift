//
//  CreateDonationViewController2.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/04/10.
//

import UIKit

class CreateDonationViewController2: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var productView: UIView!
    @IBOutlet private weak var productTextField: UITextField!
    @IBOutlet private weak var donationDescriptionView: UIView!
    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private weak var priceView: UIView!
    @IBOutlet private weak var priceTextField: UITextField!
    @IBOutlet private weak var startDateView: UIView!
    @IBOutlet private weak var startDateTextField: UITextField!
    @IBOutlet private weak var endDateView: UIView!
    @IBOutlet private weak var endDateTextField: UITextField!
    @IBOutlet private weak var imageView: UIView!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var imagePickerButton: UIButton!
    @IBOutlet weak var createButtonView: UIView!
    @IBOutlet weak var createButtonViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var donationViewArray: [UIView] = []
    @IBOutlet private var textFieldArray: [UITextField] = []

    // MARK: - IBAction
    @IBAction private func dismissButtonIsTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createButtonIsTapped(_ sender: UIButton) {
        print(viewModel.donation)
        viewModel.createDonation(donation: self.viewModel.donation)
    }
    
    @IBAction private func imagePickerButtonIsTapped(_ sender: UIButton) {
        let pickerController: UIImagePickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: - Property
    private var viewModel: CreateDonationViewModel = CreateDonationViewModel()
    private var filledView: [UITextField] = []
    private let topConstraint: Int = 86
    private let datePicker: UIDatePicker = UIDatePicker()
    private var originCreateButtonViewBottomConstraint: CGFloat = -30
    private var checkKeyboardAppearance: Bool = false
    private var donationInfo: CreateDonationInfo?
 
    // MARK: - Method
    private func setup() {
        self.view.backgroundColor = .backgroundColor
        self.contentView.backgroundColor = .backgroundColor
        self.imageView.backgroundColor = .darkGreyThree
        self.imageView.isHidden = true
        self.createButtonView.isHidden = true
        self.viewModel.delegate = self
        
        donationViewArray.forEach { $0.isHidden = true }
        setCreateButtonView()
        setTextField()
        addToolBar()
        setKeyboardNotification()
    }
    
    private func setCreateButtonView() {
        self.createButtonView.backgroundColor = .lightBluishGreen
        self.createButtonView.layer.cornerRadius = self.createButtonView.frame.height/2
    }
    
    private func transformAnimation(_ view: UIView, translationY: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            let transform = CGAffineTransform(translationX: 0, y: translationY)
            view.transform = transform
        }
        setDatePicker()
    }
    
    private func setTextField() {
        self.textFieldArray.forEach { $0.delegate = self }
    }
    
    private func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(increaseButtonViewConstraint(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(decreaseButtonViewConstraint(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func increaseButtonViewConstraint(notification: Notification) {
        guard !checkKeyboardAppearance else {
            return
        }
        
        self.checkKeyboardAppearance = true
        if let userInfo = notification.userInfo, let keyboardHeight = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                self.createButtonViewBottomConstraint.constant -= keyboardHeight.height
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func decreaseButtonViewConstraint(notification: Notification) {
        self.createButtonViewBottomConstraint.constant = self.originCreateButtonViewBottomConstraint
        self.checkKeyboardAppearance = false
    }
    
    private func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        startDateTextField.inputView = datePicker
        endDateTextField.inputView = datePicker
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.addTarget(self, action: #selector(updateTextField), for: .valueChanged)
    }
    
    private func checkCreateButtonViewValidation() {
        if !(productTextField.text!.isEmpty) && !(priceTextField.text!.isEmpty) && !(startDateTextField.text!.isEmpty) && !(endDateTextField.text!.isEmpty) {
            self.createButtonView.isHidden = false
        } else {
            self.createButtonView.isHidden = true
        }
    }
    
    @objc
    func updateTextField() {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let datePickerDate: String = dateFormatter.string(from: datePicker.date)
        
        if startDateTextField.isEditing {
            datePicker.maximumDate = dateFormatter.date(from: endDateTextField.text ?? "")
            startDateTextField.text = datePickerDate
        } else if endDateTextField.isEditing {
            datePicker.minimumDate = dateFormatter.date(from: startDateTextField.text ?? "")
            endDateTextField.text = datePickerDate
        }
    }
    
    func stringToDate(input: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "KST")
        
        if let date = formatter.date(from: input) {
            return date
        }
        
        return Date()
    }
    
    private func addToolBar() {
        let toolBarKeyboard: UIToolbar = UIToolbar()
        toolBarKeyboard.sizeToFit()
        
        let flexibleButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClicked))
        toolBarKeyboard.items = [flexibleButton, doneButton]
        let textField: [UITextField] = [priceTextField, startDateTextField, endDateTextField]
        textField.forEach { $0.inputAccessoryView = toolBarKeyboard }
    }
    
    @objc
    private func doneButtonClicked() {
        if startDateTextField.isEditing {
            transformTextField(textField: startDateTextField)
            viewModel.donation.startedAt = stringToDate(input: startDateTextField.text ?? "").iso8601withFractionalSeconds
        } else if endDateTextField.isEditing {
            transformTextField(textField: endDateTextField)
            viewModel.donation.endAt = stringToDate(input: endDateTextField.text ?? "").iso8601withFractionalSeconds
        } else {
            transformTextField(textField: priceTextField)
            if let inputPrice = priceTextField.text, let input = Int(inputPrice) {
                viewModel.donation.goal = String(input)
            }
        }
        checkCreateButtonViewValidation()
        self.view.endEditing(true)
    }
    
    private func transformTextField(textField: UITextField) {
        guard !(textField.text?.isEmpty ?? true) else {
            return
        }
        
        if textFieldArray.count > 0 && textFieldArray.contains(textField) {
            textFieldArray.removeAll { $0 == textField }
            
            filledView.insert(textField, at: 0)
            textFieldArray.first?.superview?.isHidden = false
            
            for index in 0..<filledView.count {
                let view = filledView[index].superview
                transformAnimation(view!, translationY: CGFloat(topConstraint * (index + 1)))
            }
            
            if textFieldArray.isEmpty {
                imageView.isHidden = false
            }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - UITextFieldDelegate
extension CreateDonationViewController2: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        transformTextField(textField: textField)
        checkCreateButtonViewValidation()
        
        if let textFieldText = textField.text, !(textFieldText.isEmpty) {
            if textField == productTextField {
                viewModel.donation.title = textFieldText
            } else if textField == inputTextField {
                viewModel.donation.description = textFieldText
            }
        }
        
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == priceTextField {
            let numberFormatter: NumberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            if let input: Int = Int(textField.text!) {
                let formattedNumber: String? = numberFormatter.string(from: NSNumber(value: input))
                textField.text = formattedNumber
            }
        }
    }
}

// MAKR: - UIImaePickerControlllerDelegate
extension CreateDonationViewController2: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage: UIImage = info[.originalImage] as? UIImage {
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.image = selectedImage
            imagePickerButton.backgroundColor = .clear
            viewModel.donation.postImageData = selectedImage.pngData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateDonationViewController2: CreateDonationViewModelDeleagate {
    
    func success(donationInfo: CreateDonationInfo) {
        self.donationInfo = donationInfo
        
        let viewController: MakeCompleteViewController = MakeCompleteViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.donationInfo = self.donationInfo
        present(viewController, animated: true, completion: nil)
    }
    
    func unavaliableToken() {
         
    }
}
