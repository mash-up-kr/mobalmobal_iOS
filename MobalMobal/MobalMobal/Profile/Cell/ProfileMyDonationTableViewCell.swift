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
        label.text = myDonationText[1]
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    private lazy var giveNumberOfDonation: UILabel = {
        let label: UILabel = UILabel()
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    private lazy var takeDonationTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = myDonationText[0]
        label.font = .spoqaHanSansNeo(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    private lazy var takeNumberOfDonation: UILabel = {
        let label: UILabel = UILabel()
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
        [takeStackView, giveStackView, endStackView].forEach { stackView.addArrangedSubview($0) }
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
    private let myDonationText: [String] = ["받는", "주는", "종료"]
    private lazy var myDonationNumber: [Int] = [0, 0, 0]
    let myDonationViewModel: ProfileMydonationViewModel = ProfileMydonationViewModel()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .backgroundColor
        setLayout()
        self.myDonationViewModel.delegate = self
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
    private func initMyDonationInfoNumber(_ index: Int...) {
        for indexNumber in index {
            myDonationNumber[indexNumber] = 0
        }
    }
}

// MARK: - ProfileMydonationViewModelDelegate
extension ProfileMyDonationTableViewCell: ProfileMydonationViewModelDelegate {
    func setMyDonationUI() {
        initMyDonationInfoNumber(0, 2)
        // 내가 연 도네이션 관련 정보 처리
        if let mydonationPosts: [MydonationPost] = myDonationViewModel.getMyDonationPosts() {
            for post in 0..<mydonationPosts.count {
                if myDonationViewModel.checkOutDated(postNumber: post) {
                    myDonationNumber[2] += 1
                } else {
                    myDonationNumber[0] += 1
                }
            }
            takeNumberOfDonation.text = "\(myDonationNumber[0])"
            endNumberOfDonation.text = "\(myDonationNumber[2])"
        }
    }
    func setMyDonateUI() {
        initMyDonationInfoNumber(1)
        myDonationNumber[1] = myDonationViewModel.getMyDonatePostsNumber()
        giveNumberOfDonation.text = "\(myDonationNumber[1])"
    }
}
