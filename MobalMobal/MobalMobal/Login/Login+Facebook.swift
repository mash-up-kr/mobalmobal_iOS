//
//  Login+Facebook.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/27.
//

import FBSDKLoginKit
import Firebase

// MARK: - Facebook
extension LoginViewController {
    func loginWithFacebook() {
        let manager: LoginManager = LoginManager()
        manager.logIn(permissions: ["public_profile"], from: self) { [weak self] result, error in
            if let error: Error = error {
                print("🐻 Facebook Login Error :: \(error)🐻")
                return
            }
            guard let token: AccessToken = result?.token else { return }
            print("🐻 Facebook Login Token :: \(token) 🐻")
            // 토큰 받아오는 데 성공하면 파이어베이스로 인증
            self?.loginWithFirebase(credential: FacebookAuthProvider.credential(withAccessToken: token.tokenString))
        }
    }
}
