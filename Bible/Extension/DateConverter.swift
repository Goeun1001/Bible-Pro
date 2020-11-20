//
//  Date.swift
//  Bible
//
//  Created by jge on 2020/08/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class DateConverter {
    func getNumber(number: String) -> String {
        var realNum: String = number
        if Int(number)! < 10 {
            realNum = "00" + number
        } else if Int(number)! > 9 && Int(number)! < 100 {
            realNum = "0" + number
        }
        return realNum
    }
    
    var days: Int {
        self.getRealDays()
    }
    
    func getRealDays() -> Int {
        let days = getDate()
        var newdays: Int
        if days > 182 {
            newdays = days - 182
            return newdays
        } else {
            return days
        }
    }
    
    func getDate() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "DD"
        let defaultTimeZoneStr = formatter.string(from: Date())
        return Int(defaultTimeZoneStr)!
    }
}
