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
    private var provider: Provider? {
        didSet { setProvider() }
    }
    private var loginData: LoginData? {
        didSet { loginDataChanged() }
    }
    
    func login(with fireStoreId: String, provider: Provider) {
        self.fireStoreId = fireStoreId
        self.provider = provider
        
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
        if KeychainManager.shared.getUserToken() != nil {
            if KeychainManager.shared.updateUserToken(loginData?.token.token) { print("🐻 키체인 업데이트 성공") }
        } else {
            if KeychainManager.shared.setUserToken(loginData?.token.token) { print("🐻 키체인 저장 성공") }
        }
    }
    
    private func setFireStoreId() {
        UserInfo.shared.fireStoreId = fireStoreId
    }
    
    private func setProvider() {
        UserInfo.shared.provider = provider
    }
    
}
