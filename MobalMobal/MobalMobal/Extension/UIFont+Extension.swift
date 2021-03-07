//
//  UIFont+Extension.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/08.
//

import UIKit

extension UIFont {
    enum SpoqaHanSansNeoWeight: String {
        case Bold, Light, Medium, Regular, Thin
    }
    class func spoqaHanSansNeo(ofSize fontSize: CGFloat = 15, weight: SpoqaHanSansNeoWeight) -> UIFont {
        return UIFont(name: "SpoqaHanSansNeo-\(weight)", size: fontSize)!
    }
    
    enum FutraWeigh: String {
        case Bold, Light, Medium, Regular, Thin
    }
    class func futra(ofSize fontSize: CGFloat = 15, weight: FutraWeigh) -> UIFont {
        return UIFont(name: "Futura-\(weight)", size: fontSize)!
    }
}
