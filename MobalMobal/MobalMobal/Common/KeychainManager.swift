//
//  KeychainManager.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/27.
//

import Foundation

struct KeychainManager {
    static let serviceName: String = "돈에이션"
    
    static func isEmptyUserToken() -> Bool {
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: serviceName,
                                        kSecMatchLimit: kSecMatchLimitOne,
                                        kSecReturnAttributes: true,
                                        kSecReturnData: true]

        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) != errSecSuccess { return true }
        guard let existingItem = item as? [CFString: Any], let _ = existingItem[kSecAttrGeneric] as? String else { return true }
        return false
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
    
    static func setUserToken(_ token: String) -> Bool {
        UserInfo.shared.token = token
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: serviceName,
                                        kSecAttrGeneric: token]

        return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
    }
    
    static func updateUserToken(_ token: String) -> Bool {
        UserInfo.shared.token = token
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: serviceName]
        let attributes: [CFString: Any] = [kSecAttrGeneric: token]
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == errSecSuccess
    }
    
    static func deleteUserToken() -> Bool {
        UserInfo.shared.resetUserInfo()
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                        kSecAttrService: serviceName]
     
      return SecItemDelete(query as CFDictionary) == errSecSuccess
    }
    
}
