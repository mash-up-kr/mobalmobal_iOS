//
//  UIFont+Extension.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/08.
//

import UIKit

extension UIFont {
    enum SpoqaHanSansNeoWeight: String {
        case bold = "Bold", light = "Light", medium = "Medium", regular = "Regular", thin = "Thin"
    }
    static func spoqaHanSansNeo(ofSize fontSize: CGFloat = 15, weight: SpoqaHanSansNeoWeight = .regular) -> UIFont {
        UIFont(name: "SpoqaHanSansNeo-\(weight)", size: fontSize)!
    }
    
    enum FutraWeight: String {
        case bold = "Bold", medium = "Medium"
    }
    static func futra(ofSize fontSize: CGFloat = 15, weight: FutraWeight = .medium) -> UIFont {
        UIFont(name: "Futura-\(weight)", size: fontSize)!
    }
}
