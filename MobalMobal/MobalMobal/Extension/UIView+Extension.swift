//
//  UIView+Extension.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/08.
//

import SnapKit
import UIKit

extension UIView {
    
    // layoutSubviews() 에서 재정의하여 사용
    func roundCorner() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}
