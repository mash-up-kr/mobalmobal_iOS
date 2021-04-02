//
//  SuccessChargingViewController.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/03/09.
//

import SnapKit
import UIKit

class SuccessChargingViewController: UIViewController {
    // MARK: - UIComponents
    private let closeBtn: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "menuCloseBig"), for: .normal)
        button.addTarget(self, action: #selector(closeBtnTapped), for: .touchUpInside)
        return button
    }()
    private let successImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "chargingComplete")
        return imageView
    }()
    private lazy var priceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .spoqaHanSansNeo(ofSize: 36, weight: .medium)
        label.textColor = .white
        label.text = "\(point)원"
        return label
    }()
    private let textLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .spoqaHanSansNeo(ofSize: 36, weight: .regular)
        label.textColor = .veryLightPink
        label.text = "충전완료"
        return label
    }()
    private lazy var verticalStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        [priceLabel, textLabel, successImage].forEach { stackView.addArrangedSubview($0) }
        stackView.setCustomSpacing(0, after: priceLabel)
        stackView.setCustomSpacing(40, after: textLabel)
        return stackView
    }()
    
    // MARK: - Properties
    // dummy data
    private let point: String = "30,000"
    private var setLayoutFlag: Bool = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func updateViewConstraints() {
        if !setLayoutFlag {
            setViewHierarchy()
            setConstraints()
            setLayoutFlag = true
        }
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    @objc
    private func closeBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    private func setViewHierarchy() {
        self.view.addSubviews([closeBtn, verticalStackView])
    }
    private func setConstraints() {
        closeBtn.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(44)
        }
        verticalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
