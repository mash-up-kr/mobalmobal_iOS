//
//  ProfileTableViewCell.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/28.
//

import Kingfisher
import SnapKit
import UIKit

protocol pointChargingActionDelegate: AnyObject {
    func presentPointChargingView()
}

class ProfileTableViewCell: UITableViewCell {
    // MARK: - UIComponents
    private lazy var profileImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage(named: "profile_default")
        image.layer.cornerRadius = 24
        image.layer.masksToBounds = true
        return image
    }()
    private lazy var nicknameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        return label
    }()
    private lazy var pointLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()
    private let pointButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "arrowChevronBigRight"), for: .normal)
        return button
    }()
    private lazy var pointStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        [pointLabel, pointButton].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    private lazy var userInfoVerticalStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .leading
        [nicknameLabel, pointStackView].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    // MARK: - Properties
    let cellViewModel: ProfileCellViewModel = ProfileCellViewModel()
    weak var pointChargingDelegate: pointChargingActionDelegate?
    let profileViewModel: ProfileViewModel = ProfileViewModel()
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .backgroundColor
        self.setLayout()
        self.cellViewModel.delegate = self
        setChargingPointGesture()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func chargingPointAction() {
        pointChargingDelegate?.presentPointChargingView()
    }
    
    // MARK: - Methods
    private func setChargingPointGesture() {
        let chargingPointGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chargingPointAction))
        self.pointStackView.addGestureRecognizer(chargingPointGesture)
    }
    private func setLayout() {
        self.contentView.addSubviews([profileImage, userInfoVerticalStackView])
        profileImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.size.equalTo(80)
            make.bottom.equalToSuperview().inset(60)
        }
        userInfoVerticalStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.centerY.equalTo(profileImage)
        }
    }
    private func nicknameLanguage(_ userNickname: String) -> String? {
        let koPattern: String = "[가-힣]*"
        let enPattern: String = "[A-Za-z0-9]*"
        let koPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", koPattern)
        let enPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", enPattern)
        if koPredicate.evaluate(with: userNickname) {
            return "ko"
        }
        if enPredicate.evaluate(with: userNickname) {
            return "en"
        }
        return nil
    }
    private func setNicknameUI(_ nickname: String) {
        nicknameLabel.text = "\(nickname)"
        switch nicknameLanguage(nickname) {
        case "ko":
            nicknameLabel.font = .spoqaHanSansNeo(ofSize: 24, weight: .medium)
        case "en":
            nicknameLabel.font = .futra(ofSize: 24, weight: .medium)
        default:
            nicknameLabel.font = .futra(ofSize: 24, weight: .medium)
        }
    }
}

// MARK: - ProfieCellViewModelDelegate
extension ProfileTableViewCell: ProfileCellViewModelDelegate {
    func setUIFromModel() {
        if let userNickname: String = cellViewModel.getNickname(),
           let userCash: Int = cellViewModel.getCash(),
           let userCashFormat: String = userCash.changeToCommaFormat() {
            setNicknameUI(userNickname)
            pointLabel.text = "\(userCashFormat)원"
        }
        if let imageURL: URL = URL(string: cellViewModel.getProfileImg() ?? "") {
            profileImage.kf.setImage(with: imageURL)
        } else {
            profileImage.image = UIImage(named: "profile_default")
        }
    }
}

