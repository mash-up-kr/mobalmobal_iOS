//
//  Date+Extension.swift
//  MobalMobal
//
//  Created by 임수현 on 2021/04/07.
//

import Foundation

extension Date {
    func getDueDay(of dueDate: Date) -> Int {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        
        let gregorian: Calendar = Calendar.current
        let formattedText = dateFormatter.string(from: dueDate)
        let formattedDate = dateFormatter.string(from: self)
        let period = gregorian.dateComponents([.day], from: dateFormatter.date(from: formattedDate)!, to: dateFormatter.date(from: formattedText)!).day! 
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
