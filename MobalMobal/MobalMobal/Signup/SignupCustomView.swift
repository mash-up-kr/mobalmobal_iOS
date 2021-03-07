//
//  SignUpCustomView.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/28.
//

import SnapKit
import UIKit

class SignupCustomView: UIView {
    let imageName: String
    let inputText: String
    
    let radiusInputView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: imageName))
//        imageView.frame.size = CGSize(width: 44, height: 44)
        return imageView
    }()
    
    lazy var textFieldView: UITextField = {
        let textField: UITextField = UITextField()
        textField.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        textField.textColor = .textColor
        textField.textColor = .white
        textField.placeholder = inputText
        return textField
    }()
    
    init(imageName: String, inputText: String) {
        self.imageName = imageName
        self.inputText = inputText
        super.init(frame: .zero)
        
        self.addSubview(radiusInputView)
        radiusInputView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.radiusInputView.addSubview(imageView)
        self.radiusInputView.addSubview(textFieldView)
        
        self.imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(44)
        }
        
        self.textFieldView.snp.makeConstraints { make in
            make.centerY.equalTo(self.imageView)
            make.leading.equalTo(self.imageView.snp.trailing).offset(17)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
