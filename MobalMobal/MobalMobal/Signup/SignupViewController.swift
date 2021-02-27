//
//  SignupViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/27.
//

import Then
import SnapKit
import UIKit

class SignupViewController: UIViewController {
    // MARK: - UIView
    private let nickNameView: UIView = {
        let view: UIView = SignUpCustomView(imageName: "iconlyLightProfile", inputText: "닉네임을 입력해주세요.")
        return view
    }()
    
    // MARK: - Method
    private func setup() {
        self.view.backgroundColor = .backgroundColor
        
        setNicknameView()
    }
    
    private func setNicknameView() {
        self.view.addSubview(nickNameView)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension SignupViewController {
    func setUIViewLayout() {
        
    }
}
