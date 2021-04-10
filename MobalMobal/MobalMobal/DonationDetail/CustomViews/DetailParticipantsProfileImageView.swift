//
//  DetailParticipantsProfileImageView.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/05.
//
import UIKit

/// [도네이션 상세 페이지] 참여자 프로필 이미지 뷰
class DetailParticipantsProfileImageView: UIImageView {
    // MARK: - Properties
    private let defaultImageName: String = "profile_default"
    
    // MARK: - Initializers
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        setImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setImageView() {
        self.layer.cornerRadius = self.frame.height / 2
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
        self.image = UIImage(named: defaultImageName)
    }
    
    func setImage(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        self.kf.setImage(with: url)
    }
}
