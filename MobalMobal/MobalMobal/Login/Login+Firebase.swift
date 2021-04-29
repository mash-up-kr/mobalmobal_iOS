//
//  Login+Firebase.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/27.
//

import Firebase

// MARK: - Firebase
extension LoginViewController {
    func loginWithFirebase(credential: AuthCredential, provider: Provider) {
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error: Error = error {
                print("🐻 FirebaseAuth :: error: \(error) 🐻")
                return
            }
            guard let authResult = authResult else { return }
            let fireStoreId: String = authResult.user.uid
            print("🐻 fireStoreId: \(fireStoreId)")
            
            self?.viewModel.callLoginAPI(with: fireStoreId, provider: provider)
        }
    }
}
