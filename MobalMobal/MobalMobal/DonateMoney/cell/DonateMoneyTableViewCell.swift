//
//  DonateMoneyTableViewCell.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/12.
//

import UIKit

class DonateMoneyTableViewCell: UITableViewCell {
    // MARK: - UIComponents
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        guard let image: UIImage = UIImage(named: imageName) else {
            imageView.backgroundColor = .white
            return imageView
        }
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Properties
    private let imageName: String = "arrowChevronBigRight"
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCellStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(51)
        }
        
        contentView.addSubviews([titleLabel, arrowImageView])
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(24)
        }
        
        super.updateConstraints()
    }
    
    // MARK: - Methods
    private func setCellStyle() {
        backgroundColor = .darkGreyTwo
        selectionStyle = .none
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
