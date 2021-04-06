//
//  LoginViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/02/27.
//
import AuthenticationServices
import CryptoKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import SnapKit
import UIKit

class LoginViewController: UIViewController {
    // MARK: - UI Components
    let stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()
    let logoImageView: UIImageView = {
        let imageName: String = "doneImage"
        let imageView: UIImageView = UIImageView()
        let image: UIImage? = UIImage(named: imageName)
        imageView.image = image
        return imageView
    }()
    let googleButton: UIView = {
        let button: UIView = CustomLoginButton(title: "Google로 로그인하기", iconName: "googleLogo")
        return button
    }()
    let facebookButton: UIView = {
        let button: UIView = CustomLoginButton(title: "Facebook으로 로그인하기", iconName: "facebookLogo")
        return button
    }()
    let appleButton: UIView = {
        let button: UIView = CustomLoginButton(title: "Apple로 로그인하기", iconName: "appleLogo")
        return button
    }()
    
    // MARK: - Properties
    let viewModel: LoginViewModel = LoginViewModel()
    fileprivate var currentNonce: String?
        
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .backgroundColor
        setActions()
        updateViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func updateViewConstraints() {
        view .addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(319.0 / 375.0)
        }
        
        [logoImageView, googleButton, facebookButton, appleButton].forEach { stackView.addArrangedSubview($0) }
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(logoImageView.snp.width).multipliedBy(202.0 / 302.0)
        }
        googleButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        facebookButton.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(googleButton)
        }
        appleButton.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(googleButton)
            make.bottom.equalToSuperview()
        }
        
        setStackViewCustomSpacing()
        super.updateViewConstraints()
    }
        
    // MARK: - Actions
    private func setActions() {
        let googleLoginTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickGoogleLoginButton))
        googleButton.addGestureRecognizer(googleLoginTap)
        
        let facebookLoginTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickFacebookLoginButton))
        facebookButton.addGestureRecognizer(facebookLoginTap)
        
        let appleLoginTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickAppleLoginButton))
        appleButton.addGestureRecognizer(appleLoginTap)
    }
    
    private func setStackViewCustomSpacing() {
        stackView.setCustomSpacing(view.frame.height * 58 / 812, after: logoImageView)
        stackView.setCustomSpacing(view.frame.height * 13 / 812, after: googleButton)
        stackView.setCustomSpacing(view.frame.height * 13 / 812, after: facebookButton)
    }
    
    @IBAction private func clickGoogleLoginButton() {
        loginWithGoogle()
    }
    @IBAction private func clickFacebookLoginButton() {
        loginWithFacebook()
    }
    @IBAction private func clickAppleLoginButton() {
        loginWithApple()
    }
    
    private func presentMainViewController() {
        let mainVC: MainViewController = MainViewController()
        let navigation: UINavigationController = UINavigationController(rootViewController: mainVC)
        navigation.modalPresentationStyle = .fullScreen
        self.present(navigation, animated: true)
    }
    
    private func pushSignUpViewController() {
        let signUpVC: SignupViewController = SignupViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func successLogin() {
        presentMainViewController()
    }
    
    func needToSignUp() {
        pushSignUpViewController()
    }
}

// MARK: - Firebase
extension LoginViewController {
    private func loginWithFirebase(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error: Error = error {
                print("🐻 FirebaseAuth :: error: \(error) 🐻")
                return
            }
            guard let authResult = authResult else { return }
            let fireStoreId: String = authResult.user.uid
            print("🐻 fireStoreId: \(fireStoreId)")
            self?.viewModel.login(with: fireStoreId)
            
//            user?.getIDTokenForcingRefresh(true) {idToken, error in ... }
        }
    }
}

// MARK: - Google
extension LoginViewController: GIDSignInDelegate {
    private func loginWithGoogle() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().signIn()
    }
    
    // MARK: Google Guideline
    
    // 구글 로그인 연동 시도 했을 시 호출
    func sign(_ signIn: GIDSignIn?, didSignInFor user: GIDGoogleUser?, withError error: Error?) {
        if let error: Error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("🐻 GoogleLogin :: The user has not signed in before or they have since signed out. 🐻")
            } else {
                print("🐻 GoogleLogin :: error: \(error.localizedDescription) 🐻")
            }
            return
        }
        guard let user = user else {
            print("🐻 GoogleLogin :: error: User Data Not Found 🐻")
            return
        }
        print("🐻 GoogleLogin :: user: \(user)")
        guard let authentication = user.authentication else { return }
        let credential: AuthCredential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        loginWithFirebase(credential: credential)
    }
    
    // 구글 로그인 연동 해제 시 호출
    func sign(_ signIn: GIDSignIn?, didDisconnectWith user: GIDGoogleUser?, withError error: Error?) {
        print("🐻 GoogleLogin :: disconnected 🐻")
    }
}

// MARK: - Facebook
extension LoginViewController {
    private func loginWithFacebook() {
        let manager: LoginManager = LoginManager()
        manager.logIn(permissions: ["public_profile"], from: self) { [weak self] result, error in
            if let error: Error = error {
                print("🐻 Facebook Login :: Process error: \(error)🐻")
                return
            }
            guard let result = result else {
                print("🐻 FacebookLogin :: No Result 🐻")
                return
            }
            if result.isCancelled {
                print("🐻 FacebookLogin :: Cancelled 🐻")
                return
            }
            guard let token: AccessToken = result.token else {
                print("🐻 FacebookLogin :: Token Error 🐻")
                return
            }
            print("🐻 FacebookLogin :: Token: \(token) 🐻")
            
            // 토큰 받아오는 데 성공하면 파이어베이스로 인증
            self?.loginWithFirebase(credential: FacebookAuthProvider.credential(withAccessToken: token.tokenString))
        }
    }
}

// MARK: - Apple
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    private func loginWithApple() {
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
    private func randomNonceString(length: Int = 32) -> String {
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
    private func sha256(_ input: String) -> String {
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
            
            guard let nonce: String = currentNonce else {
                print("🐻 AppleLogin :: nonce 없음")
                return
            }
            guard let token: Data = appleIDCredential.identityToken else {
                print("🐻 AppleLogin :: Unable to fetch identity token")
                return
            }
            guard let tokenString: String = String(data: token, encoding: .utf8) else {
                print("🐻 AppleLogin :: Unable to serialize token string from data: \(token.debugDescription)")
                return
            }
            print("🐻 AppleLogin :: Token: \(tokenString)")
            print("🐻 AppleLogin :: ID: \(appleIDCredential.user)")
            
            // 토큰 받아오는 데 성공하면 파이어베이스로 인증
            let credential: AuthCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
            loginWithFirebase(credential: credential)
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시 호출
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("🐻 AppleLogin :: 로그인 실패 \(error.localizedDescription)")
    }
}
