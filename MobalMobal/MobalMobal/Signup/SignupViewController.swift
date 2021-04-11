//
//  SignupViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/27.
//

import SnapKit
import Then
import UIKit

class SignupViewController: DoneBaseViewController {
    // Fire Store ID: UserInfo.shared.fireStoreId 사용하면 됩니다.
    
    // MARK: - UIView
    private let signupViewModel = SignupViewModel()
    private var signupUser: SignupUser?
    
    private let nickNameView: SignupCustomView = {
        let view: SignupCustomView = SignupCustomView(imageName: "iconlyLightProfile", inputText: "닉네임을 입력해주세요.")
        view.backgroundColor = .white7
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let phoneNumberView: SignupCustomView = {
        let view: SignupCustomView = SignupCustomView(imageName: "iconlyLightCall", inputText: "전화번호를 입력해주세요. (선택)")
        view.backgroundColor = .white7
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let emailView: SignupCustomView = {
        let view: SignupCustomView = SignupCustomView(imageName: "iconlyLightMessage", inputText: "이메일을 입력해주세요. (선택)")
        view.backgroundColor = .white7
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let agreementView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    private let agreementButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "iconlyLightCheckOff"), for: .normal)
        button.addTarget(self, action: #selector(agreementButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    private let agreementLabel: UILabel = {
        let label: UILabel = UILabel()
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "이용약관, 개인정보 수집 및 이용", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        let remainText: String = "에 모두 동의 합니다."
        label.numberOfLines = 0
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        
        label.text = label.attributedText!.string + remainText
        label.textColor = .white
        return label
    }()
    
    private let termsOfServiceButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(termsOfServiceButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func termsOfServiceButtonIsTapped() {
        print("이용약관 버튼 눌림")
    }
    
    private let completeButton: UIButton = {
        let button: UIButton = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .greyishBrown
        button.isEnabled = false
        button.addTarget(self, action: #selector(completButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func completButtonIsTapped() {
        self.signupUser?.fireStoreId = UserInfo.shared.fireStoreId ?? ""
        signupViewModel.signup(signupUser: self.signupUser!)
    }
    
    private let completeButtonLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "가입완료"
        label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        label.textColor = UIColor(red: 121.0 / 255, green: 121.0 / 255, blue: 121.0 / 255, alpha: 1)
        return label
    }()
    
    // MARK: - Property
    private var agreementButtonState: Bool = false
    
    // MARK: - Method
    private func setup() {
        self.view.backgroundColor = .backgroundColor
        self.signupViewModel.delegate = self
        
        setUIViewLayout()
        setNavigationItems(title: "회원 가입", backButtonImageName: "arrowChevronBigLeft", action: #selector(backButtonTapped))
    }
    
    @objc
    private func agreementButtonIsTapped() {
        agreementButtonState.toggle()
        
        if !agreementButtonState {
            agreementButton.setImage(UIImage(named: "iconlyLightCheckOff"), for: .normal)
        } else {
            agreementButton.setImage(UIImage(named: "iconlyLightCheckOn"), for: .normal)
            completButtonCheck()
        }
    }
    
    @objc
    private func backButtonTapped() {
         navigationController?.popViewController(animated: true)
    }
    
    private func setNicknameView() {
        self.view.addSubview(nickNameView)
        self.nickNameView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(59)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        nickNameView.textFieldView.delegate = self
    }
    
    private func setPhoneNumberView() {
        self.view.addSubview(phoneNumberView)
        self.phoneNumberView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(nickNameView.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        phoneNumberView.textFieldView.delegate = self
    }
    
    private func setEmailView() {
        self.view.addSubview(emailView)
        self.emailView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(phoneNumberView.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        emailView.textFieldView.delegate = self
    }
    
    private func setAgreementView() {
        self.view.addSubview(agreementView)
        self.agreementView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(emailView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        self.agreementView.addSubview(agreementButton)
        self.agreementButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.agreementView)
            make.leading.equalToSuperview()
            make.width.equalTo(43)
        }
        
        self.agreementView.addSubview(agreementLabel)
        self.agreementLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.agreementView)
            make.leading.equalTo(self.agreementButton.snp.trailing).offset(7)
            make.trailing.equalTo(self.agreementView.snp.trailing).offset(0)
        }
        
        self.agreementView.addSubview(termsOfServiceButton)
        self.termsOfServiceButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.agreementLabel)
            make.leading.top.equalTo(self.agreementLabel)
            make.width.equalTo(self.agreementLabel)
        }
    }
    
    private func setCompleteButtonView() {
        self.view.addSubview(completeButton)
        self.completeButton.snp.makeConstraints { make in
            make.top.equalTo(agreementView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(90)
            make.height.equalTo(60)
        }
        
        self.completeButton.addSubview(completeButtonLabel)
        self.completeButtonLabel.snp.makeConstraints { make in
            make.center.equalTo(completeButton)
        }
    }
    
    private func completButtonCheck() {
        if signupViewModel.apiValidation(nickNameView.textFieldView, agreementButtonIsPressed: self.agreementButtonState) {
            self.completeButton.isEnabled = true
            self.completeButton.backgroundColor = .lightBluishGreen
        } else {
            self.completeButton.isEnabled = false
            self.completeButton.backgroundColor = .greyishBrown
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension SignupViewController {
    func setUIViewLayout() {
        setNicknameView()
        setPhoneNumberView()
        setEmailView()
        setAgreementView()
        setCompleteButtonView()
    }
}

extension SignupViewController: SignUpViewModelDelegate {
    func requestNickNameAgain() {
        print("닉네임 다시 입력하게")
    }
    
    func success() {
        print("성공")
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nickNameView.textFieldView {
            guard signupViewModel.nicknameTextFieldIsFilled(textField) == true else {
                alertController("빈칸입니다 !")
                completButtonCheck()
                return false
            }
            
            if let nicknameInput = nickNameView.textFieldView.text {
                self.signupUser?.nickname = nicknameInput
            }
            
        } else if textField == phoneNumberView.textFieldView {
            guard signupViewModel.phoneNumberTextFieldIsFilled(textField) == true else {
                textField.text = ""
                alertController("올바르지 않은 형식입니다 !")
                return false
            }
            
            if let phoneNumberInput = phoneNumberView.textFieldView.text {
                self.signupUser?.phoneNumber = phoneNumberInput
            }
        } else if textField == emailView.textFieldView {
            guard signupViewModel.emailTextFieldIsFilled(textField) == true else {
                alertController("올바르지 않은 이메일 형식입니다 !")
                return false
            }
        }
        
        completButtonCheck()
        self.view.endEditing(true)
        return true
    }
}
