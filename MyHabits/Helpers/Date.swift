//
//  Date.swift
//  MyHabits
//
//  Created by Дина Шварова on 20.01.2023.
//

import Foundation

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var beforeYesterday: Date { return Date().dayBeforeYesterday }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
    }

    var dayBeforeYesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: Date())!
    }
}
