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
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let mask: CAShapeLayer = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        
        self.layer.mask = mask
    }
    
    func drawShadow(color: UIColor = .black, alpha: Float = 0.2, shadowX: CGFloat = 0, shadowY: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
        layer.shadowRadius = blur / 2
        
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx: CGFloat = -spread
            let rect: CGRect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
