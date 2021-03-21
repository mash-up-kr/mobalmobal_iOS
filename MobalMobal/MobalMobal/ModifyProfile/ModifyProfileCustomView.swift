//
//  ModifyProfileCustomView.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/03/20.
//

import Foundation
import SnapKit
import UIKit

class ModifyProfileCustomView: UIView {
    private let imageName: String
    private let inputText: String
    private let keyboardType: UIKeyboardType
    
    private let radiusInputView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .white7
        view.layer.cornerRadius = 30
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: imageName))
        return imageView
    }()
    
    private lazy var textFieldView: UITextField = {
        let textField: UITextField = UITextField()
        textField.font = .spoqaHanSansNeo(ofSize: 15, weight: .bold)
        textField.textColor = .white
        textField.text = inputText
        textField.keyboardType = keyboardType
        return textField
    }()
    
    init(imageName: String, inputText: String, keyboardType: UIKeyboardType) {
        self.imageName = imageName
        self.inputText = inputText
        self.keyboardType = keyboardType
        super.init(frame: .zero)
        
        self.addSubview(radiusInputView)
        radiusInputView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.radiusInputView.addSubviews([imageView, textFieldView])
        self.imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(44)
        }
        
        self.textFieldView.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(17)
            make.trailing.equalToSuperview().inset(17)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
