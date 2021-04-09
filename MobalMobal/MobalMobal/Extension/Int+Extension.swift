//
//  Int+Extension.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/07.
//

import Foundation

extension Int {
    func changeToCommaFormat() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) else { return nil }
        return formattedNumber
    }
}
