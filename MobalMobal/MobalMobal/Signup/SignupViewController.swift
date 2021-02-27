//
//  SignupViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/27.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: - UIView
    private let nicknameLabel: UILabel = UILabel()
    private let nicknameTextField: UITextField = UITextField()
    private let phoneNumbereLabel: UILabel = UILabel()
    private let phoneNumberTextField: UITextField = UITextField()
    private let emailLabel: UILabel = UILabel()
    private let emailTextField: UITextField = UITextField()
    private let agreementLabel: UILabel = UILabel()
    private let agreementDetailLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
    }
}

extension SignupViewController {
    func setUIViewLayout() {
        
    }
}
