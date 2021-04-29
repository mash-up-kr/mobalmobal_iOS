//
//  LoginViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/02/27.
//

import SnapKit
import UIKit

class LoginViewController: DoneBaseViewController {
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
    lazy var guestButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("둘러보기", for: .normal)
        button.addTarget(self, action: #selector(clickGuestButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    let viewModel: LoginViewModel = LoginViewModel()
    var currentNonce: String?
        
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .backgroundColor
        setActions()
        updateViewConstraints()
        
        // UserInfo와 키체인 초기화
        UserInfo.shared.resetUserInfo()
        _ = KeychainManager.deleteUserToken()
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
        
        [logoImageView, googleButton, facebookButton, appleButton, guestButton].forEach { stackView.addArrangedSubview($0) }
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
        }
        guestButton.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(googleButton)
            make.bottom.equalToSuperview()
        }
        
        stackView.setCustomSpacing(view.frame.height * 58 / 812, after: logoImageView)
        stackView.setCustomSpacing(view.frame.height * 13 / 812, after: googleButton)
        stackView.setCustomSpacing(view.frame.height * 13 / 812, after: facebookButton)
        stackView.setCustomSpacing(view.frame.height * 13 / 812, after: appleButton)
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
    
    @IBAction private func clickGoogleLoginButton() {
        loginWithGoogle()
    }
    @IBAction private func clickFacebookLoginButton() {
        loginWithFacebook()
    }
    @IBAction private func clickAppleLoginButton() {
        loginWithApple()
    }
    @objc
    private func clickGuestButton() {
        dismissNavigationController()
    }
    
    // MARK: - Methods
    private func dismissNavigationController() {
        navigationController?.dismiss(animated: true)
    }
    
    private func pushSignUpViewController() {
        let signUpVC: SignupViewController = SignupViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func successLogin() {
        dismissNavigationController()
    }
    
    func needToSignUp() {
        pushSignUpViewController()
    }
}
