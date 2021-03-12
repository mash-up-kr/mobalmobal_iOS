//
//  SuccessDonationViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/12.
//
import SnapKit
import UIKit

class SuccessDonationViewController: UIViewController {
    // MARK: - UIComponents
    private lazy var closeButton: UIButton = {
        let button: UIButton = UIButton()
        button.addTarget(self, action: #selector(clickCloseButton), for: .touchUpInside)
        guard let image: UIImage = UIImage(named: closeButtonImageName) else {
            button.setTitle("X", for: .normal)
            button.setTitleColor(.white, for: .normal)
            return button
        }
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    private lazy var moneyLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = moneyLabelString
        label.font = .spoqaHanSansNeo(ofSize: 36, weight: .medium)
        label.textColor = .white
        return label
    }()
    private lazy var successLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = successLabelString
        label.font = .spoqaHanSansNeo(ofSize: 36, weight: .regular)
        label.textColor = .veryLightPink
        return label
    }()
    private lazy var successImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        guard let image: UIImage = UIImage(named: successImageName) else {
            imageView.snp.makeConstraints { make in make.size.equalTo(200) }
            imageView.backgroundColor = .white
            return imageView
        }
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Properties
    // dummy data
    private let money: String = "30,000"

    // components data
    private let closeButtonImageName: String = "menuCloseBig"
    private let successImageName: String = "doneImage"
    private lazy var moneyLabelString: String = "\(money)원"
    private let successLabelString: String = "후원완료"
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
    }
    
    override func updateViewConstraints() {
        view.addSubviews([closeButton, stackView])
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(44)
            make.trailing.equalToSuperview().inset(view.frame.width * 10 / 375)
        }
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().inset(view.frame.width * 16 / 375)
        }
        
        [moneyLabel, successLabel, successImageView].forEach { stackView.addArrangedSubview($0) }
        stackView.setCustomSpacing(view.frame.height * 40 / 812, after: successLabel)
        moneyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }        
        successImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    @objc
    private func clickCloseButton() {
        dismissViewController()
    }
    
    // MARK: - Methods
    private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
