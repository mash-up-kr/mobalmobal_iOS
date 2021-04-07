//
//  MyDonationTableViewCell.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/02/28.
//

import SnapKit
import UIKit

class ProfileMyDonationTableViewCell: UITableViewCell {
    // MARK: - UIComponents
    private lazy var giveDonationTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = myDonationText[0]
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    private lazy var giveNumberOfDonation: UILabel = {
        let label: UILabel = UILabel()
        label.text = "\(myDonationNumber[0])"
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    private lazy var takeDonationTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = myDonationText[1]
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    private lazy var takeNumberOfDonation: UILabel = {
        let label: UILabel = UILabel()
        label.text = "\(myDonationNumber[1])"
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    private lazy var endDonationTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = myDonationText[2]
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    private lazy var endNumberOfDonation: UILabel = {
        let label: UILabel = UILabel()
        label.text = "\(myDonationNumber[2])"
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var giveStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        setVerticalStackView(stackView)
        [giveNumberOfDonation, giveDonationTitleLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    private lazy var takeStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        setVerticalStackView(stackView)
        [takeNumberOfDonation, takeDonationTitleLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    private lazy var endStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        setVerticalStackView(stackView)
        [endNumberOfDonation, endDonationTitleLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        [giveStackView, takeStackView, endStackView].forEach { stackView.addArrangedSubview($0) }
        stackView.spacing = 69
        return stackView
    }()
    private let myDontaionView: UIView = {
        let view: UIView = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .purpleishBlue
        return view
    }()
    private let cellTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "내 도네"
        label.textColor = .white
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
        return label
    }()
    
    // MARK: - Properties
    // myDonationText는 변경가능성이있다고하여서 빼두었습니다.
    private let myDonationText: [String] = ["받는", "주는", "종료"]
    private let profileViewModel: ProfileViewModel = ProfileViewModel()
    // dummy data
    private let myDonationNumber: [Int] = [1, 3, 10]
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .backgroundColor
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setVerticalStackView(_ stackView: UIStackView) {
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.backgroundColor = .purpleishBlue
    }
    private func setLayout() {
        self.contentView.addSubviews([cellTitleLabel, myDontaionView])
        self.myDontaionView.addSubview(horizontalStackView)
        cellTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        myDontaionView.snp.makeConstraints { make in
            make.top.equalTo(cellTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.bottom.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview().inset(48)
        }
    }
    private func mydonationBinding() {
        
    }
}
