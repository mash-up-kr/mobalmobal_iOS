//
//  DetailParticipantsView.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/05.
//
import Kingfisher
import SnapKit
import UIKit


/// [도네이션 상세 페이지] 여러 참여자 프로필 이미지를 묶어서 보여주는 뷰
class DetailParticipantsView: UIView {
    // MARK: - UI Components
    let firstCircleView: UIImageView = DetailParticipantsProfileImageView()
    let secondCircleView: UIImageView = DetailParticipantsProfileImageView()
    let moreButtonView: UIView = DetailParticipantsMoreButtonView()
    
    // MARK: - Initializers
    init() {
        super.init(frame: CGRect())
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setConstraints() {
        [firstCircleView, secondCircleView, moreButtonView].forEach { self.addSubview($0) }
        
        firstCircleView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.size.equalTo(40)
        }
        
        secondCircleView.snp.makeConstraints { make in
            make.leading.equalTo(firstCircleView).offset(34)
            make.size.centerY.equalTo(firstCircleView)
        }
        
        moreButtonView.snp.makeConstraints { make in
            make.leading.equalTo(secondCircleView).offset(34)
            make.trailing.equalToSuperview()
            make.size.centerY.equalTo(secondCircleView)
        }
    }
}
