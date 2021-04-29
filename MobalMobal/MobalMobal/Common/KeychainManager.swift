//
//  KeychainManager.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/27.
//

import Foundation

struct KeychainManager {
    static let serviceName: String = "돈에이션"
    
    static func setUserToken(_ token: String?) -> Bool {
        // TODO: 삭제할 부분
        UserDefaults.standard.setValue(token, forKey: UserDefaultsKeys.userToken)
        UserInfo.shared.token = token
        
        // 남길 부분
        guard let token = token else { return false }
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: serviceName,
                                        kSecAttrGeneric: token]

        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    static func getUserToken() -> String? {
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: serviceName,
                                        kSecMatchLimit: kSecMatchLimitOne,
                                        kSecReturnAttributes: true,
                                        kSecReturnData: true]

        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return nil }

        guard let existingItem = item as? [CFString: Any], let token = existingItem[kSecAttrGeneric] as? String else { return nil }
        return token
    }
    
    static func updateUserToken(_ token: String?) -> Bool {
        guard let token = token else { return false }
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: serviceName]
        let attributes: [CFString: Any] = [kSecAttrGeneric: token]
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == errSecSuccess
    }
    
    static func deleteUserToken() -> Bool {
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: serviceName]
     
      return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
    
}
