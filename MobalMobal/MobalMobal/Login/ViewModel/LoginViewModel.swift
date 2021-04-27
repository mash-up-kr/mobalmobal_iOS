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
        if getUserToken() != nil {
            if updateUserToken(loginData?.token.token) { print("🐻 키체인 업데이트 성공") }
        } else {
            if setUserToken(loginData?.token.token) { print("🐻 키체인 저장 성공") }
        }
    }
    
    private func setFireStoreId() {
        UserInfo.shared.fireStoreId = fireStoreId
    }
    
    private func setProvider() {
        UserInfo.shared.provider = provider
    }
    
    private func setUserToken(_ token: String?) -> Bool {
        // TODO: 삭제할 부분
        UserDefaults.standard.setValue(token, forKey: UserDefaultsKeys.userToken)
        UserInfo.shared.token = token
        
        // 남길 부분
        guard let fireStoreId = fireStoreId, let token = token else { return false }
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: "돈에이션",
                                        kSecAttrAccount: fireStoreId,
                                        kSecAttrGeneric: token]

        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    private func getUserToken() -> String? {
        guard let fireStoreId = fireStoreId else { return nil }
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: "돈에이션",
                                        kSecAttrAccount: fireStoreId,
                                        kSecMatchLimit: kSecMatchLimitOne,
                                        kSecReturnAttributes: true,
                                        kSecReturnData: true]

        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }

        guard let existingItem = item as? [CFString: Any], let token = existingItem[kSecAttrGeneric] as? String else { return nil }
        return token
    }
    
    private func updateUserToken(_ token: String?) -> Bool {
        guard let fireStoreId = fireStoreId, let token = token else { return false }
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: "돈에이션",
                                        kSecAttrAccount: fireStoreId]
        let attributes: [CFString: Any] = [kSecAttrAccount: fireStoreId, kSecAttrGeneric: token]
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == errSecSuccess
    }
    
    private func deleteUserToken() -> Bool {
        guard let fireStoreId = fireStoreId else { return false }
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: "돈에이션",
                                        kSecAttrAccount: fireStoreId]
     
      return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
}
