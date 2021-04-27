//
//  Login+Apple.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/27.
//

import AuthenticationServices
import CryptoKit
import Firebase

// MARK: - Apple
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    func loginWithApple() {
        let nonce: String = randomNonceString()
        currentNonce = nonce
        
        let appleIDProvider: ASAuthorizationAppleIDProvider = ASAuthorizationAppleIDProvider()
        let request: ASAuthorizationAppleIDRequest = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce) // 애플 로그인 요청 시 nonce의 SHA256 해시를 전송해야 한다.
        
        let authorizationController: ASAuthorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // MARK: Firebase Guideline
    
    /// 랜덤 nonce를 생성하는 함수.
    /// 애플에 로그인 요청 시 nonce의 SHA256 해시를 전송한다.
    /// 로그인 응답으로 들어온 nonce를 통해 ID 토큰이 명시적으로 부여되었는지 확인한다.
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result: String = ""
        var remainingLength: Int = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode: Int32 = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("🐻 Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 { return }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    /// 문자열의 SHA256 해시를 만드는 함수.
    func sha256(_ input: String) -> String {
        let inputData: Data = Data(input.utf8)
        let hashedData: SHA256Digest = SHA256.hash(data: inputData)
        let hashString: String = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    // MARK: Apple Guideline
    // Apple login 모달 창 띄우기
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
    
    // Apple ID 연동 성공 시 호출
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            guard let nonce: String = currentNonce else { return }
            
            guard let token: Data = appleIDCredential.identityToken else {
                print("🐻 Apple Login :: Unable to fetch identity token")
                return
            }
            guard let tokenString: String = String(data: token, encoding: .utf8) else {
                print("🐻 Apple Login :: Unable to serialize token string from data: \(token.debugDescription)")
                return
            }
            print("🐻 Apple Login Token: \(tokenString)")
            
            // 토큰 받아오는 데 성공하면 파이어베이스로 인증
            let credential: AuthCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
            loginWithFirebase(credential: credential, provider: .apple)
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시 호출
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("🐻 Apple Login :: 로그인 실패 \(error.localizedDescription)")
    }
}
