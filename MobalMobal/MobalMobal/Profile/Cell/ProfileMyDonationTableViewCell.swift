//
//  MyDonationTableViewCell.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/28.
//

import SnapKit
import UIKit

class ProfileMyDonationTableViewCell: UITableViewCell {
    private let myDonationText: [String] = ["받는", "주는", "종료"]
    private let myDonationNumber: [Int] = [1, 3, 10]        //서버로부터 값 받아야됨.
    private let numberOfDonation: UILabel = {
        let label: UILabel = UILabel()
        label.text = "1"
        return label
    }()
    private let numberOfDonationTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "받는"
        return label
    }()
    private let verticalStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.backgroundColor = .blue
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let myDontaionView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .purpleishBlue
        return view
    }()
    private let horizontalStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        return stackView
    }()
    private func setLayout() {
        [myDontaionView, verticalStackView, horizontalStackView].forEach { contentView.addSubview($0) }
        myDontaionView.snp.makeConstraints { make in
//            make.leading.equalTo(contentView.snp.leading).inset(80)
//            make.top.equalTo(contentView.snp.top).offset(12)
//            make.bottom.equalTo(contentView.snp.bottom).offset(80)
//            make.trailing.equalTo(contentView.snp.trailing).offset(80)
            make.edges.equalToSuperview().inset(20)
        }
        // 세로
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(myDontaionView.snp.top).inset(18)
            make.bottom.equalTo(myDontaionView.snp.bottom).inset(15)
            make.width.equalTo((myDontaionView.bounds.width) / 3)
        }
        // 가로
        horizontalStackView.snp.makeConstraints { make in
            
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .purpleishBlue
        self.verticalStackView.addArrangedSubview(numberOfDonationTitle)
        self.verticalStackView.addArrangedSubview(numberOfDonation)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
