//
//  SignUpCustomView.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/28.
//

import SnapKit
import UIKit

class SignUpCustomView: UIView {
    let imageName: String
    let inputText: String
    
    let radiusInputView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor(red: 255.0 / 255, green: 255.0 / 255, blue: 255.0 / 255, alpha: 0.07)
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: imageName))
        return imageView
    }()
    
    lazy var textFieldView: UITextField = {
        let textField: UITextField = UITextField()
        textField.font = UIFont(name: "SpoqaHanSansNeo", size: 15)
        textField.textColor = .textColor
        textField.textColor = .white
        textField.placeholder = inputText
        return textField
    }()
    
    init(imageName: String, inputText: String) {
        self.imageName = imageName
        self.inputText = inputText
        super.init(frame: .zero)
        
        self.radiusInputView.addSubview(imageView)
        self.radiusInputView.addSubview(textFieldView)
        
        self.radiusInputView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalToSuperview().inset(59)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        self.imageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.radiusInputView)
            make.leading.equalTo(self.radiusInputView.snp.trailing).offset(17)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
