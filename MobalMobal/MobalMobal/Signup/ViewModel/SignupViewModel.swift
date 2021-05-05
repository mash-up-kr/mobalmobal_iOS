//
//  SignupViewModel.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/04/11.
//

import UIKit

protocol SignupViewModelProtocol {
    func nicknameTextFieldIsFilled(_ textField: UITextField) -> Bool
    func phoneNumberTextFieldIsFilled(_ textField: UITextField) -> Bool
    func emailTextFieldIsFilled(_ textField: UITextField) -> Bool
    func agreementButtonIsChecked(_ button: UIButton) -> Bool
    func apiValidation(_ nicknameTextField: UITextField, agreementButtonIsPressed: Bool) -> Bool
    func signup(signupUser: SignupUser)
}

protocol SignUpViewModelDelegate: class {
    func requestNickNameAgain()
    func success()
}

class SignupViewModel: SignupViewModelProtocol {
    
    // MARK: - Property
    var loginData: LoginData?
    weak var delegate: SignUpViewModelDelegate?
    
    // MARK: - Method
    func nicknameTextFieldIsFilled(_ textField: UITextField) -> Bool {
        guard let inputText = textField.text else { return false }
        return !inputText.isEmpty 
    }
    
    func phoneNumberTextFieldIsFilled(_ textField: UITextField) -> Bool {
        if let number = textField.text {
            let numberRegularExpression = "[0-9]{11}"
            let checkNumber = NSPredicate(format: "SELF MATCHES %@", numberRegularExpression)
            return checkNumber.evaluate(with: number)
        }
        return false
    }
    
    func emailTextFieldIsFilled(_ textField: UITextField) -> Bool {
        if let email = textField.text {
            let emailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let checkEmail = NSPredicate(format: "SELF MATCHES %@", emailRegularExpression)
            return checkEmail.evaluate(with: email)
        }
        return false
    }
    
    func agreementButtonIsChecked(_ button: UIButton) -> Bool {
        return button.state == .selected
    }
    
    func signup(signupUser: SignupUser) {
        DoneProvider.signup(signupUser: signupUser) { [weak self] response in
            guard let self = self else {
                return
            }
            
            self.loginData = response.data
            
            if response.code == 400 {
                self.delegate?.requestNickNameAgain()
            } else if response.code == 200 {
                self.delegate?.success()
                if let data = self.loginData {
                    if KeychainManager.shared.setUserToken(data.token.token) {
                        print("Signup Token 저장 성공")
                    }
                }
            }
        } failure: { (error) in
            print(error.localizedDescription)
            return
        }
    }
    
    func apiValidation(_ nicknameTextField: UITextField, agreementButtonIsPressed: Bool) -> Bool {
        return nicknameTextFieldIsFilled(nicknameTextField) && agreementButtonIsPressed
    }
}
