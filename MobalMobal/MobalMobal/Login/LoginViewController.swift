//
//  LoginViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/02/27.
//
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import SnapKit
import UIKit

class LoginViewController: UIViewController {
    // MARK: - UI Components
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
    
    // MARK: - Initializer
    private func setSuperview() {
        view.backgroundColor = .backgroundColor
        [logoImageView, facebookButton, googleButton, appleButton].forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(155)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(36)
        }
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(58)
            make.leading.trailing.equalToSuperview().inset(28)
            make.height.equalTo(60)
        }
        facebookButton.snp.makeConstraints { make in
            make.top.equalTo(googleButton.snp.bottom).offset(13)
            make.leading.trailing.height.equalTo(googleButton)
        }
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(facebookButton.snp.bottom).offset(13)
            make.leading.trailing.height.equalTo(googleButton)
        }
    }
    
    private func setActions() {
        let googleLoginTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickGoogleLoginButton))
        googleButton.addGestureRecognizer(googleLoginTap)
        let facebookLoginTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickFacebookLoginButton))
        facebookButton.addGestureRecognizer(facebookLoginTap)
        let appleLoginTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickAppleLoginButton))
        appleButton.addGestureRecognizer(appleLoginTap)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSuperview()
        setConstraints()
        setActions()
        
        // Google Login 실행될 ViewController 설정
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    // MARK: - Actions
    @IBAction private func clickFacebookLoginButton() {
        loginWithFacebook()
    }
    @IBAction private func clickGoogleLoginButton() {
        loginWithGoogle()
    }
    @IBAction private func clickAppleLoginButton() {
        // TODO: loginWithApple()
        
        // TODO: 임시로 상세보기 화면으로 가는 코드
        let detailVC: DonationDetailViewController = DonationDetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true)
    }
}

// MARK: - Firebase
extension LoginViewController {
    private func loginWithFirebase(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            // guard let self = self else { return }
            if let error: Error = error {
                print("🐻 FirebaseAuth :: error: \(error) 🐻")
                return
            }
            
            let user: User? = authResult?.user
            user?.getIDTokenForcingRefresh(true) { idToken, error in
                if let error: Error = error {
                    print("🐻 FirebaseAuth :: error: \(error) 🐻")
                    return
                }
                guard let idToken = idToken else {
                    print("🐻 FirebaseAuth :: idToken Error 🐻")
                    return
                }
                print("🐻 FirebaseAuth :: idToken: \(idToken) 🐻")
            }
        }
    }
}

// MARK: - Google
extension LoginViewController: GIDSignInDelegate {
    private func loginWithGoogle() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().signIn()
    }
    
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
extension LoginViewController {
    // TODO: private func loginWithApple() {}
}
