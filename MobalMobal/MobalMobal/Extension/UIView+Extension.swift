//
//  UIView+Extension.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/03/07.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }

    // layoutSubviews() 에서 재정의하여 사용
    func roundCorner() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}
