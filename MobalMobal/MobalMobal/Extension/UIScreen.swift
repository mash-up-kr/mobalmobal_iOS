//
//  UIScreen.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/05/06.
//

import UIKit

enum Device {
    case iPhoneSE
    
    var portraitSize: CGSize {
        switch self {
        case .iPhoneSE:
            return CGSize(width: 320, height: 568)
        }
    }
    
    var landscapeSize: CGSize {
        return CGSize(width: portraitSize.height, height: portraitSize.width)
    }
}

extension UIScreen {
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    static var isLandscapeMode: Bool {
        if let landscape = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape {
            return landscape
        }
        return true
    }
    
    static let isSe: Bool = UIScreen.isLandscapeMode ? (UIScreen.screenSize == Device.iPhoneSE.landscapeSize) : (UIScreen.screenSize == Device.iPhoneSE.portraitSize)
}
