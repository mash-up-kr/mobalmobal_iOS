//
//  DonateMoneyViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/12.
//

import UIKit

class DonateMoneyViewController: UIViewController {
    // MARK: - UIComponents
    private let label: UILabel = UILabel()
    
    // MARK: - Properties
        
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        view.addSubview(label)
        label.text = "후원하기"
        label.textColor = .white
        label.snp.makeConstraints { make in make.center.equalToSuperview() }
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
}
