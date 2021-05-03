//
//  DonateCompleteViewController.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/10.
//

import SnapKit
import UIKit

class DonateCompleteViewController: UIViewController {
    // MARK: - UIComponenets
    let closeButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "menuCloseBig"), for: .normal)
        button.addTarget(self, action: #selector(clickCloseButton), for: .touchUpInside)
        return button
    }()
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = nickname
        label.font = .spoqaHanSansNeo(ofSize: 19, weight: .bold)
        label.textColor = .white
        return label
    }()
    let zosaLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "는"
        label.font = .spoqaHanSansNeo(ofSize: 19, weight: .regular)
        label.textColor = .white
        return label
    }()
    lazy var giftLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "\(giftName) 가지고 싶어요"
        label.font = .spoqaHanSansNeo(ofSize: 19, weight: .regular)
        label.textColor = .white
        return label
    }()
    lazy var completeImageView: UIImageView = {
        let image: UIImage = placeholderImage
        let imageView: UIImageView = UIImageView(image: image)
        return imageView
    }()
    let completeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "후원완료"
        label.font = .spoqaHanSansNeo(ofSize: 22, weight: .bold)
        label.textColor = .darkCream
        return label
    }()
    lazy var moneyLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "\(money)원"
        label.font = .spoqaHanSansNeo(ofSize: 38, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    // MARK: Groups
    lazy var firstGroup: UIStackView = {
        let group: UIStackView = UIStackView()
        group.axis = .horizontal
        group.addArrangedSubview(nameLabel)
        group.addArrangedSubview(zosaLabel)
        return group
    }()
    lazy var labelGroup: UIStackView = {
        let group: UIStackView = UIStackView()
        group.axis = .vertical
        group.alignment = .center
        group.addArrangedSubview(firstGroup)
        group.addArrangedSubview(giftLabel)
        return group
    }()
    lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        [labelGroup, completeImageView, completeLabel, moneyLabel].forEach { stackView.addArrangedSubview($0) }
        stackView.setCustomSpacing(55, after: labelGroup)
        stackView.setCustomSpacing(60, after: completeImageView)
        stackView.setCustomSpacing(22, after: completeLabel)
        return stackView
    }()
    
    // MARK: - Properties
    private let nickname: String
    private let giftName: String
    private let money: String
    private let placeholderImage: UIImage = UIImage(named: "doneImage")!
    
    // MARK: - Initializer
    init(nickname: String, giftName: String, moneyAmount: Int) {
        self.nickname = nickname
        self.giftName = giftName
        self.money = moneyAmount.changeToCommaFormat() ?? "0"
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Methods
    private func setLayout() {
        view.backgroundColor = .backgroundColor
        view.addSubviews([closeButton, stackView])
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(2)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(44)
        }
        
        completeImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(completeImageView.snp.width).multipliedBy(181.6/268.8)
        }
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(44)
        }        
    }
    
    @objc
    private func clickCloseButton() {
        navigationController?.dismiss(animated: true)
    }
}
