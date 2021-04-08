//
//  UITextField+Extension.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/03/13.
//

import UIKit

extension UITextField {
    func setPlaceholderColor(_ color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}
