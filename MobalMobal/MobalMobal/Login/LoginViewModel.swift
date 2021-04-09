//
//  LoginViewModel.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/01.
//

import Alamofire
import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func needToSignUp()
    func successLogin()
}

class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
    
    private var fireStoreId: String? {
        didSet { setFireStoreId() }
    }
    private var loginData: LoginData? {
        didSet { loginDataChanged() }
    }
    
    func login(with fireStoreId: String) {
        self.fireStoreId = fireStoreId
        
        DoneProvider.login(fireStoreId: fireStoreId) { [weak self] response in
            self?.loginData = response.data
            if response.code == 200 {
                self?.delegate?.successLogin()
            } else if response.code == 404 {
                self?.delegate?.needToSignUp()
            }
        } failure: { _ in
            return
        }
    }
    
    private func loginDataChanged() {
        setUserToken(loginData?.token.token)
    }
    
    private func setFireStoreId() {
        UserInfo.shared.fireStoreId = fireStoreId
    }
    
    private func setUserToken(_ token: String?) {
        UserDefaults.standard.setValue(token, forKey: UserDefaultsKeys.userToken)
        UserInfo.shared.token = token
    }
}
