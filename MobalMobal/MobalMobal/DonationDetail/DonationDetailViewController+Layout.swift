//
//  DonationDetailViewController+Layout.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/01.
//
import SnapKit
import UIKit

extension DonationDetailViewController {
    func setScrollViewConstraints() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Top Area
    func setTopImageAreaConstraints() {
        contentView.addSubviews([detailImageView, translucentView, progressLabel, dDayLabel, progressBarView])
        setDetailimageViewConstraints()
        setTranslucentViewConstraints()
        setProgressLabelConstraints()
        setDDayLabelConstraints()
        setProgressBarViewConstraints()
    }
    private func setDetailimageViewConstraints() {
        detailImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(detailImageView.snp.width).multipliedBy(229.0 / 375.0)
        }
    }
    private func setTranslucentViewConstraints() {
        translucentView.snp.makeConstraints { make in
            make.edges.equalTo(detailImageView)
        }
    }
    private func setProgressLabelConstraints() {
        progressLabel.snp.makeConstraints { make in
            make.leading.equalTo(translucentView).inset(26)
            make.bottom.equalTo(translucentView).inset(16)
        }
    }
    private func setDDayLabelConstraints() {
        dDayLabel.snp.makeConstraints { make in
            make.trailing.equalTo(translucentView).inset(24)
            make.centerY.equalTo(progressLabel)
        }
    }
    private func setProgressBarViewConstraints() {
        progressBarView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(translucentView)
            make.width.equalTo(200)
            make.height.equalTo(2)
        }
    }
    
    // MARK: - Mid Area
    func setMidDescriptionAreaConstraints() {
        nameGiftGroupView.addSubviews([nameLabel, zosaLabel, giftLabel, wantLabel])
        setNameLabelConstraints()
        setZosaLabelConstraints()
        setGiftLabelConstraints()
        setWantLabelConstraints()
        
        contentView.addSubviews([profileImageView, nameGiftGroupView, descriptionLabel])
        setProfileImageViewConstraints()
        setNameGiftGroupViewConstraints()
        setDescriptionLabelConstraints()
    }
    private func setNameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
    }
    private func setZosaLabelConstraints() {
        zosaLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(5)
            make.bottom.equalTo(nameLabel)
        }
    }
    private func setGiftLabelConstraints() {
        giftLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.bottom.equalToSuperview()
        }
    }
    private func setWantLabelConstraints() {
        wantLabel.snp.makeConstraints { make in
            make.leading.equalTo(giftLabel.snp.trailing).offset(4)
            make.bottom.equalTo(giftLabel)
        }
    }
    private func setProfileImageViewConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(detailImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(22)
            make.size.equalTo(58)
        }
    }
    private func setNameGiftGroupViewConstraints() {
        nameGiftGroupView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.centerY.equalTo(profileImageView)
        }
    }
    private func setDescriptionLabelConstraints() {
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
            make.leading.equalTo(profileImageView)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Bottom Area
    func setBottomDetailInfoAreaConstraints() {
        contentView.addSubviews([detailGroupView, donationButton])
        setDetailGroupViewConstraints()
        setDonationButtonConstraints()
        
        detailGroupView.addSubviews([destinationTitleLabel, destinationNumberLabel, fundAmountTitleLabel, fundAmountNumberLabel, participantsTitleLabel, participantsCountLabel, participantsProfilesView, endDateTitleLabel, endDateLabel])
        setDestinationConstraints()
        setFundAmountConstraints()
        setParticipantsConstraints()
        setEndDateConstraints()
    }
    private func setDetailGroupViewConstraints() {
        detailGroupView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(descriptionLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
        }
    }
    private func setDonationButtonConstraints() {
        donationButton.snp.makeConstraints { make in
            make.top.equalTo(detailGroupView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.bottom.greaterThanOrEqualTo(view)
            make.height.equalTo(85)
        }
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
