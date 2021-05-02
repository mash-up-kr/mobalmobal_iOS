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
    @IBOutlet private weak var createButtonViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var donationViewArray: [UIView] = []
    @IBOutlet private var textFieldArray: [UITextField] = []

    // MARK: - IBAction
    @IBAction private func dismissButtonIsTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func imagePickerButtonIsTapped(_ sender: UIButton) {
        let pickerController: UIImagePickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: - Property
    private var filledView: [UITextField] = []
    private let topConstraint: Int = 86
    private let datePicker: UIDatePicker = UIDatePicker()
 
    // MARK: - Method
    private func setup() {
        self.view.backgroundColor = .backgroundColor
        self.contentView.backgroundColor = .backgroundColor
        self.imageView.backgroundColor = .darkGreyThree
        self.imageView.isHidden = true
        setCreateButtonView()
        
        donationViewArray.forEach { $0.isHidden = true }
        
        setTextField()
        addToolBar()
    }
    
    private func setCreateButtonView() {
        self.createButtonView.backgroundColor = .greyishBrown
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
//        NotificationCenter.default.addObserver(self, selector: <#T##Selector#>, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func setDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "ko_KR")
        startDateTextField.inputView = datePicker
        endDateTextField.inputView = datePicker
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.addTarget(self, action: #selector(updateTextField), for: .valueChanged)
    }
    
    @objc
    func updateTextField() {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd hh:mm"
        let datePickerDate: String = dateFormatter.string(from: datePicker.date)
        
        if startDateTextField.isEditing {
            startDateTextField.text = datePickerDate
        } else if endDateTextField.isEditing {
            endDateTextField.text = datePickerDate
        }
    }
    
    private func addToolBar() {
        let toolBarKeyboard: UIToolbar = UIToolbar()
        toolBarKeyboard.sizeToFit()
        
        let flexibleButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonClicked(_:)))
        toolBarKeyboard.items = [flexibleButton, doneButton]
        let textField: [UITextField] = [priceTextField, startDateTextField, endDateTextField]
        textField.forEach { $0.inputAccessoryView = toolBarKeyboard }
    }
    
    @objc
    private func doneButtonClicked(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    private func transformTextField(textField: UITextField) {
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
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
