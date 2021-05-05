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
        didSet { fireStoreIdChanged() }
    }
    private var provider: Provider? {
        didSet { providerChanged() }
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
            } else if response.code == 404 {
                self?.delegate?.needToSignUp()
            }
        } failure: { _ in return }
    }
    
    private func callUserAPI() {
        DoneProvider.getUserProfile { [weak self]  response in
            self?.userData = response.data?.user
            if response.code == 200 {
                self?.delegate?.successLogin()
                UserInfo.shared.needToUpdate = true
                return
            }
            guard let message = response.message else { return }
            print("🐻 유저 정보를 불러오는데 실패했습니다. : \(message)")
        } failure: { _ in return }
    }
    
    private func fireStoreIdChanged() {
        UserInfo.shared.fireStoreId = fireStoreId
    }
    
    private func providerChanged() {
        UserInfo.shared.provider = provider
    }
    
    private func userTokenChanged() {
        UserInfo.shared.token = userToken
        
        guard let token = userToken else { return }
        if KeychainManager.isEmptyUserToken() {
            if KeychainManager.setUserToken(token) {
                print("🐻 키체인 저장 성공")
            } else {
                print("🐻 키체인 저장 실패")
            }
        } else {
            if KeychainManager.updateUserToken(token) {
                print("🐻 키체인 업데이트 성공")
            } else {
                print("🐻 키체인 업데이트 실패")
            }
        }
    }
    
    private func userDataChanged() {
        UserInfo.shared.updateUserInfo(data: userData)
    }
}
