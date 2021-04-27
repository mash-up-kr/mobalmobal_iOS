//
//  KeychainManager.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/27.
//

import Foundation

class KeychainManager {
    static let shared: KeychainManager = KeychainManager()
    let serviceName: String = "돈에이션"
    var fireStoreId: String? {
        UserInfo.shared.fireStoreId
    }
    
    func setUserToken(_ token: String?) -> Bool {
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
    
    func getUserToken() -> String? {
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
    
    func updateUserToken(_ token: String?) -> Bool {
        guard let fireStoreId = fireStoreId, let token = token else { return false }
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: "돈에이션",
                                        kSecAttrAccount: fireStoreId]
        let attributes: [CFString: Any] = [kSecAttrAccount: fireStoreId, kSecAttrGeneric: token]
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == errSecSuccess
    }
    
    func deleteUserToken() -> Bool {
        guard let fireStoreId = fireStoreId else { return false }
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: "돈에이션",
                                        kSecAttrAccount: fireStoreId]
     
      return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
    
}
