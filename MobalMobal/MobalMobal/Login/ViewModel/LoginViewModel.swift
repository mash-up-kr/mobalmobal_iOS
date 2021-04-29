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
    private var userToken: String? {
        didSet { userTokenChanged() }
    }
    private var userData: ProfileUser? {
        didSet { userDataChanged() }
    }
    
    func callLoginAPI(with fireStoreId: String, provider: Provider) {
        self.fireStoreId = fireStoreId
        self.provider = provider
        
        DoneProvider.login(fireStoreId: fireStoreId) { [weak self] response in
            self?.userToken = response.data?.token.token
            if response.code == 200 {
                self?.callUserAPI()
                self?.delegate?.successLogin()
            } else if response.code == 404 {
                self?.delegate?.needToSignUp()
            }
        } failure: { _ in return }
    }
    
    private func callUserAPI() {
        DoneProvider.getUserProfile { [weak self]  response in
            self?.userData = response.data?.user
            if response.code != 200 {
                guard let message = response.message else { return }
                print("🐻 유저 정보를 불러오는데 실패했습니다. : \(message)")
            }
        } failure: { _ in return }
    }
    
    private func userDataChanged() {
        setUserInfo()
    }
    
    private func userTokenChanged() {
        setUserToken()
        
        if KeychainManager.shared.getUserToken() != nil {
            if KeychainManager.shared.updateUserToken(userToken) {
                print("🐻 키체인 업데이트 성공")
            } else {
                print("🐻 키체인 업데이트 실패")
            }
        } else {
            if KeychainManager.shared.setUserToken(userToken) {
                print("🐻 키체인 저장 성공")
            } else {
                print("🐻 키체인 저장 실패")
            }
        }
    }
    
    private func setUserToken() {
        UserInfo.shared.token = userToken
    }
    
    private func setFireStoreId() {
        UserInfo.shared.fireStoreId = fireStoreId
    }
    
    private func setProvider() {
        UserInfo.shared.provider = provider
    }
    
    private func setUserInfo() {
        UserInfo.shared.updateUserInfo(data: userData)
    }
}
