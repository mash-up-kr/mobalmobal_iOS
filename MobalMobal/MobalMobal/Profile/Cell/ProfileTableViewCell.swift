//
//  ProfileTableViewCell.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/28.
//

import SnapKit
import UIKit

class ProfileTableViewCell: UITableViewCell {
    // MARK: - UIComponents
    private lazy var profileImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage(named: self.userImg)
        return image
    }()
    private lazy var nicknameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = self.nickname
        label.textColor = .white
        label.font = .futra(ofSize: 24, weight: .medium)
        return label
    }()
    private lazy var pointLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "\(self.point ?? 0)원"
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
    // dummy data
    private var nickname: String?
    private var point: Int?
    private let userImg: String = "profile"
    private let profileViewModel: ProfileViewModel = ProfileViewModel()
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .backgroundColor
        self.setLayout()
        self.binding()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
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
    
    private func binding() {
        self.nickname = profileViewModel.getUserNickname()
        self.point = profileViewModel.getUserCash()
        // 이미지처리는 s3이후에 진행하겟습니다
    }
}
