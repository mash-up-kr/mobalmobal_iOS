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
        image.layer.cornerRadius = 24
        return image
    }()
    let nicknameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Jercy"
        label.textColor = .white
        label.font = UIFont(name: "futura-Bold", size: 24)
//        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    let pointButton: UIButton = {
        let button: UIButton = UIButton()
        return button
    }()
    let pointView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    let pointLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "12,340원"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    let pointDetailImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .white
        return image
    }()
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .backgroundColor
        self.setLayout()
    }
    
    private func setLayout() {
        pointView.addSubview(pointButton)
        pointView.addSubview(pointDetailImage)
        [profileImage, nicknameLabel, pointLabel, pointView].forEach { contentView.addSubview( $0 ) }
        profileImage.snp.makeConstraints {  make in
            make.top.equalTo(contentView.snp.top).inset(20)
            make.leading.equalTo(contentView.snp.leading).offset(21)
            make.height.width.equalTo(80)
            make.bottom.equalTo(contentView.snp.bottom).inset(60)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.top)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        pointLabel.snp.makeConstraints { make in
            make.leading.equalTo(pointView)
            make.centerY.equalTo(pointView)
            
        }
        pointDetailImage.snp.makeConstraints { make in
            make.leading.equalTo(pointLabel.snp.trailing)
            make.top.bottom.equalTo(pointLabel)
        }
        pointView.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(23)
            make.leading.equalTo(nicknameLabel.snp.leading)
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
