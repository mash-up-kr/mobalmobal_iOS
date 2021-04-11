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
    func signup(signupUser: SignupUser, success: @escaping (ParseResponse<LoginData>) -> Void, failure: @escaping (Error) -> Void)
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
        if !inputText.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func phoneNumberTextFieldIsFilled(_ textField: UITextField) -> Bool {
        if var number = textField.text {
            number = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let checkNumber = NSPredicate(format: "%@", number)
            return checkNumber.evaluate(with: number)
        }
        return false
    }
    
    func emailTextFieldIsFilled(_ textField: UITextField) -> Bool {
        if var email = textField.text {
            email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let checkEmail = NSPredicate(format: "%@", email)
            return checkEmail.evaluate(with: email)
        }
        return false
    }
    
    func agreementButtonIsChecked(_ button: UIButton) -> Bool {
        return button.state == .selected
    }
    
    func signup(signupUser: SignupUser, success: @escaping (ParseResponse<LoginData>) -> Void, failure: @escaping (Error) -> Void) {
        DoneProvider.signup(signupUser: signupUser) { [weak self] response in
            guard let self = self else {
                return
            }
            
            self.loginData = response.data
            
            if response.code == 400 {
                self.delegate?.requestNickNameAgain()
            } else if response.code == 200 {
                self.delegate?.success()
                if let token = self.loginData {
                    self.setUserToken(loginData: token)
                }
            }
        } failure: { (error) in
            failure(error)
        }
    }
    
    private func setUserToken(loginData: LoginData) {
        UserDefaults.standard.setValue(loginData.token.token, forKey: UserDefaultsKeys.userToken)
        UserInfo.shared.token = loginData.token.token
    }
}
