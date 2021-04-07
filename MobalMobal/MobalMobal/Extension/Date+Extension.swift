//
//  Date+Extension.swift
//  MobalMobal
//
//  Created by 송서영 on 2021/04/08.
//

import Foundation

 extension Date {
     func getDueDay(of dueDate: Date) -> Int {
         let gregorian: Calendar = Calendar(identifier: .gregorian)
         let period = gregorian.dateComponents([.day], from: self, to: dueDate).day!
         return period
     }
 }
