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
    
    func getDDayString(to date: Date?) -> String {
        guard let date = date else {
            return "D-알수없음"
        }
        
        let dueDay: Int = Date().getDueDay(of: date)
        if dueDay > 0 {
            return "D-\(dueDay)"
        } else if dueDay == 0 {
            return "D-Day"
        } else {
            return "D+\(-dueDay)"
        }
    }
}
