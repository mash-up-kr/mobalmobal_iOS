//
//  Date+Extension.swift
//  MobalMobal
//
//  Created by jeongminho on 2021/04/07.
//

import UIKit

extension Date {
    func dayOfYear(date: Date) -> String {
        let calendar: Calendar = Calendar.current
        guard let components = calendar.dateComponents([.year], from: date).date?.description else { return "" }
        return components
    }
}
