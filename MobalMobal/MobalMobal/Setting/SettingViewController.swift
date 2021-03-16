//
//  SettingViewController.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/02/27.
//

import SnapKit
import UIKit

class SettingViewController: UIViewController {
    // MARK: - UIView
    private let settingLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont(name: "futura", size: 18)
        label.textColor = .black
        label.text = "설정"
        return label
    }()
    
    // MARK: - Property
    
    // MARK: - Method
    private func setup() {
        self.view.backgroundColor = .backgroundColor
        self.setNavigationController()
        self.setTitleLabel()
    }
    
    private func setNavigationController() {
        self.title = "설정"
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .black94
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setTitleLabel() {
        self.view.addSubview(settingLabel)
        self.settingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(view).offset(100)
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

