//
//  ProfileTableViewCell.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/28.
//

import SnapKit
import UIKit

class ProfileTableViewCell: UITableViewCell {
    let profileImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.image = UIImage(named: "Profile")
        return image
    }()
    var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "서영서"
        return label
    }()
    let nicknameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "백호"
        return label
    }()
    let editButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("수정", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    let settingButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("설정", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    let pointView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 8.0
        view.backgroundColor = .red
        return view
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init")
        self.contentView.backgroundColor = .black
        self.setLayout()
    }
    
    private func setLayout() {
        print("setLayout ✨")
        [profileImage, nameLabel, nicknameLabel, editButton, settingButton, pointView].forEach { contentView.addSubview( $0) }
        profileImage.snp.makeConstraints {  make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(21)
            make.height.width.equalTo(80)
        }
        profileImage.layer.cornerRadius = 10.0
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        pointView.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.leading.equalTo(profileImage.snp.leading)
            make.trailing.equalTo(settingButton.snp.trailing)
            make.height.equalTo(150)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
