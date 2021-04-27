//
//  Login+Google.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/27.
//

import Firebase
import GoogleSignIn

// MARK: - Google
extension LoginViewController: GIDSignInDelegate {
    func loginWithGoogle() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().signIn()
    }
    
    // MARK: Google Guideline
    // 구글 로그인 연동 시도 했을 시 호출
    func sign(_ signIn: GIDSignIn?, didSignInFor user: GIDGoogleUser?, withError error: Error?) {
        if let error: Error = error {
            print("🐻 Google Login Error :: \(error.localizedDescription) 🐻")
            return
        }
        guard let authentication = user?.authentication else { return }
        let credential: AuthCredential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        loginWithFirebase(credential: credential)
    }
    
    // 구글 로그인 연동 해제 시 호출
    func sign(_ signIn: GIDSignIn?, didDisconnectWith user: GIDGoogleUser?, withError error: Error?) {
        print("🐻 Google Login :: disconnected 🐻")
    }
}
