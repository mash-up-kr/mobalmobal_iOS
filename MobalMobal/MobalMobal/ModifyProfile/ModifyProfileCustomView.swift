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
    let imageName: String
    let inputText: String
    
    let radiusInputView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .white7
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: UIImage(named: imageName))
        return imageView
    }()
    
    lazy var textFieldView: UITextField = {
        let textField: UITextField = UITextField()
        textField.font = .spoqaHanSansNeo(ofSize: 15, weight: .bold)
        textField.textColor = .white
        textField.text = inputText
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
