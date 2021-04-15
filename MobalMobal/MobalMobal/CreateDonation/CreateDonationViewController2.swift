//
//  CreateDonationViewController2.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/04/10.
//

import UIKit

class CreateDonationViewController2: UIViewController {
    
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
    @IBOutlet private var donationViewArray: [UIView] = []
    @IBOutlet private var textFieldArray: [UITextField] = []
    
    // MARK: - IBAction
    @IBAction func dismissButtonIsTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Property
    private var filledView: [UITextField] = []
    private let topConstraint: Int = 86
 
    // MARK: - Method
    private func setup() {
        self.view.backgroundColor = .backgroundColor
        self.contentView.backgroundColor = .backgroundColor
        
        donationViewArray.forEach { $0.isHidden = true }
        
        setTextField()
    }
    
    private func transformAnimation(_ view: UIView, translationY: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            let transform = CGAffineTransform(translationX: 0, y: translationY)
            view.transform = transform
        }
    }
    
    private func setTextField() {
        self.textFieldArray.forEach { $0.delegate = self }
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
    
        if textFieldArray.count > 0 && textFieldArray.contains(textField) {
            textFieldArray.removeAll { $0 == textField }
            filledView.insert(textField, at: 0)
            textFieldArray.first?.superview?.isHidden = false
            
            for index in 0..<filledView.count {
                let view = filledView[index].superview
                transformAnimation(view!, translationY: CGFloat(topConstraint * (index + 1)))
            }
        }
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
