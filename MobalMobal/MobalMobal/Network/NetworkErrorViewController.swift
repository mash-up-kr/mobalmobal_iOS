//
//  NetworkErrorViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/05/07.
//

import UIKit
import SnapKit

class NetworkErrorViewController: UIViewController {
    
    // MARK: - UIView
    private let dismissButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "menuCloseBig"), for: .normal)
        button.addTarget(self, action: #selector(dismissButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 30, weight: .bold)
        label.text = "네트워크 에러"
        label.textColor = .white
        return label
    }()
    
    private let errorImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "errorImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let retryButtonImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "round_shadow_button")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let retryButton: UIButton = {
        let button: UIButton = UIButton()
        button.layer.borderColor = UIColor.brightYellow50.cgColor
        button.setTitle("다시시도", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .spoqaHanSansNeo(ofSize: 14, weight: .bold)
    
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(retryButtonIsTapped), for: .touchUpInside)
            
        return button
    }()

    // MARK: - Method
    private func setup() {
        setLayout()
    }
    
    @objc
    private func dismissButtonIsTapped() {
        print("dismiss 버튼 눌림")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func retryButtonIsTapped() {
        print("다시시도 버튼 눌림")
    }
    
    private func setLayout() {
        self.view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.size.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(2)
            make.trailing.equalToSuperview().inset(10)
        }
        
        self.view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.dismissButton.snp.bottom).offset(85)
        }
        
        self.view.addSubview(errorImageView)
        errorImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.errorLabel.snp.bottom).offset(54)
        }
        
        self.view.addSubview(retryButtonImage)
        retryButtonImage.snp.makeConstraints { make in
            make.top.equalTo(self.errorImageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(117)
        }
        
        self.view.addSubview(retryButton)
        retryButton.snp.makeConstraints { make in
            make.center.equalTo(self.retryButtonImage)
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}
