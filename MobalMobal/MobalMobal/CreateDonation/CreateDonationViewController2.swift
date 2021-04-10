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
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var donationInputView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    // MARK: - IBAction
    @IBAction func dismissButtonIsTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Property
    @IBOutlet var donationViewArray: [UIView] = []
    
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
        self.productTextField.delegate = self
        self.inputTextField.delegate = self
        self.priceTextField.delegate = self
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
        if textField == productTextField {
            transformAnimation(productView, translationY: 100)
            self.donationInputView.isHidden = false
        } else if textField == inputTextField {
            transformAnimation(donationInputView, translationY: 100)
            transformAnimation(productView, translationY: 200)
            self.priceView.isHidden = false
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
