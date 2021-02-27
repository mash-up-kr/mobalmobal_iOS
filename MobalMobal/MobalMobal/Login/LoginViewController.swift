//
//  LoginViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/02/27.
//
import FBSDKLoginKit
import Firebase
import SnapKit
import UIKit

class LoginViewController: UIViewController {
    // MARK: - UI Components
    let logoImageView: UIImageView = {
        let imageName: String = ""
        let imageView: UIImageView = UIImageView()
        let image: UIImage? = UIImage(named: imageName)
        imageView.backgroundColor = .gray
        imageView.image = image
        return imageView
    }()
    let googleButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Google Login", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    let facebookButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Facebook Login", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    let appleButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Apple Login", for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    // MARK: - Initializer
    private func setSubviews() {
        [logoImageView, facebookButton, googleButton, appleButton].forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(150)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        facebookButton.snp.makeConstraints { make in
            make.top.equalTo(googleButton.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(50)
        }
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(facebookButton.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(50)
        }
    }
    
    private func setActions() {
        facebookButton.addTarget(self, action: #selector(clickFacebookLogin), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubviews()
        setConstraints()
        setActions()
    }
    
    // MARK: - Actions
    @IBAction private func clickFacebookLogin() {
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
