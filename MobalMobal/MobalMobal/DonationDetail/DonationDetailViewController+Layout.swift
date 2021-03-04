//
//  DonationDetailViewController+Layout.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/01.
//

import UIKit

extension DonationDetailViewController {
    func setConstraints() {
        setTopImageAreaConstraints()
        setMidDescriptionAreaConstraints()
        setBottomDetailInfoAreaConstraints()
    }
    
    private func setTopImageAreaConstraints() {
        view.backgroundColor = .backgroundColor
        
        [detailImageView].forEach { view.addSubview($0) }
        view.addSubview(detailImageView)
        
        detailImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(229)
        }
        
        [translucentView].forEach { detailImageView.addSubview($0) }
        
        translucentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [progressLabel, progressBarView, dDayLabel].forEach { translucentView.addSubview($0) }
        
        progressBarView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(2)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(26)
            make.bottom.equalToSuperview().inset(16)
        }
        
        dDayLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalTo(progressLabel)
        }
    }
    
    private func setMidDescriptionAreaConstraints() {
        let nameGiftGroupView: UIView = setNameGiftGroupView()
        
        [profileImageView, nameGiftGroupView, descriptionLabel].forEach { view.addSubview($0) }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(detailImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(22)
            make.size.equalTo(58)
        }
        
        nameGiftGroupView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.centerY.equalTo(profileImageView)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.leading.equalTo(profileImageView)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setBottomDetailInfoAreaConstraints() {
        let detailGroupView: UIView = setDetailGroupView()
        
        [donationButton, detailGroupView].forEach { view.addSubview($0) }
        donationButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(85)
        }
        
        detailGroupView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(donationButton.snp.top)
        }
    }
    
    private func setNameGiftGroupView() -> UIView {
        let nameGiftGroupView: UIView = UIView()
        
        [nameLabel, zosaLabel, giftLabel, wantLabel].forEach { nameGiftGroupView.addSubview($0) }
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        zosaLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(5)
            make.bottom.equalTo(nameLabel)
        }
        
        giftLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.bottom.equalToSuperview()
        }
        
        wantLabel.snp.makeConstraints { make in
            make.leading.equalTo(giftLabel.snp.trailing).offset(4)
            make.bottom.equalTo(giftLabel)
        }
        
        return nameGiftGroupView
    }
    
    private func setDetailGroupView() -> UIView {
        let detailGroupView: UIView = UIView()
        detailGroupView.backgroundColor = .blackTwo
        
        [destinationTitleLabel, destinationNumberLabel, fundAmountTitleLabel, fundAmountNumberLabel, participantsTitleLabel, participantsCountLabel, participantsProfilesView, endDateTitleLabel, endDateLabel].forEach { detailGroupView.addSubview($0) }
        
        setDestinationConstraints()
        setFundAmountConstraints()
        setParticipantsConstraints()
        setEndDateConstraints()
        
        return detailGroupView
    }
    
    private func setDestinationConstraints() {
        destinationTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.leading.equalToSuperview().inset(20)
        }
        destinationNumberLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalTo(destinationTitleLabel)
        }
    }
    
    private func setFundAmountConstraints() {
        fundAmountTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(destinationTitleLabel.snp.bottom).offset(32)
            make.leading.equalTo(destinationTitleLabel)
        }
        fundAmountNumberLabel.snp.makeConstraints { make in
            make.trailing.equalTo(destinationNumberLabel)
            make.centerY.equalTo(fundAmountTitleLabel)
        }
    }
    
    private func setParticipantsConstraints() {
        participantsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(fundAmountTitleLabel.snp.bottom).offset(41)
            make.leading.equalTo(destinationTitleLabel)
        }
        participantsCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(participantsTitleLabel.snp.trailing).offset(6)
            make.centerY.equalTo(participantsTitleLabel)
        }
        participantsProfilesView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(26)
            make.centerY.equalTo(participantsTitleLabel)
        }
    }
    
    private func setEndDateConstraints() {
        endDateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(participantsTitleLabel.snp.bottom).offset(41)
            make.leading.equalTo(destinationTitleLabel)
            make.bottom.equalToSuperview().inset(48)
        }
        endDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(destinationNumberLabel)
            make.centerY.equalTo(endDateTitleLabel)
        }
    }
}
