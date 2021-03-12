//
//  DetailParticipantsMoreButtonView.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/05.
//
import UIKit

/// [도네이션 상세 페이지] 참여자 더보기 버튼 뷰
class DetailParticipantsMoreButtonView: UIView {
    // MARK: - UI Components
    private let dot1: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .blackTwo
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    private let dot2: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .blackTwo
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    private let dot3: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .blackTwo
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func updateConstraints() {
        [dot1, dot2, dot3].forEach { self.addSubview($0) }
        
        dot2.snp.makeConstraints { make in
            make.size.equalTo(3)
            make.center.equalToSuperview()
        }
        dot1.snp.makeConstraints { make in
            make.size.centerY.equalTo(dot2)
            make.trailing.equalTo(dot2.snp.leading).offset(-4)
        }
        dot3.snp.makeConstraints { make in
            make.size.centerY.equalTo(dot2)
            make.leading.equalTo(dot2.snp.trailing).offset(4)
        }
        
        super.updateConstraints()
    }
}
