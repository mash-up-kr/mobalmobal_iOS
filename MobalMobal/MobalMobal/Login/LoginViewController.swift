//
//  LoginViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/02/27.
//
import SnapKit
import UIKit

class LoginViewController: UIViewController {
    // MARK: - UI Components
    let logoImageView: UIImageView = {
        let imageName: String = ""
        let imageView: UIImageView = UIImageView()
        let image: UIImage? = UIImage(named: imageName)
        imageView.backgroundColor = .red
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
        button.backgroundColor = .red
        return button
    }()
    let appleButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Apple Login", for: .normal)
        button.backgroundColor = .red
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
            make.centerX.equalToSuperview()
        }
        facebookButton.snp.makeConstraints { make in
            make.top.equalTo(googleButton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        appleButton.snp.makeConstraints { make in
            make.top.equalTo(facebookButton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubviews()
        setConstraints()
    }
}
