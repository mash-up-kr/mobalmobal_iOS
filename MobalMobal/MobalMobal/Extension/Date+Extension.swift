//
//  Date+Extension.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/07.
//

import Foundation

extension Date {
    func getDueDay(of dueDate: Date) -> Int {
        let gregorian: Calendar = Calendar(identifier: .gregorian)
        let period = gregorian.dateComponents([.day], from: self, to: dueDate).day!
        return period
    }
}
