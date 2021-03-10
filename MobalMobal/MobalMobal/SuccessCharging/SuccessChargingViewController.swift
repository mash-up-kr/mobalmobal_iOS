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
    private let scrollView: UIScrollView = {
        let scrollView: UIScrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .backgroundColor
        return scrollView
    }()
    private let contentView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .backgroundColor
        return view
    }()
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
    lazy var priceLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .spoqaHanSansNeo(ofSize: 36, weight: .medium)
        label.textColor = .white
        label.text = "\(point)원"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let textLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .spoqaHanSansNeo(ofSize: 36, weight: .regular)
        label.textColor = .veryLightPink
        label.text = "충전완료"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    // MARK: - Properties
    // dummy data
    private let point: String = "30,000"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @objc
    private func closeBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    private func setViewHierarchy() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubviews([closeBtn, priceLabel, textLabel, successImage])
    }
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(46)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(44)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(closeBtn.snp.bottom).offset(86)
            make.centerX.equalToSuperview()
        }
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        successImage.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(175)
        }
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        setViewHierarchy()
        setConstraints()
    }
}
