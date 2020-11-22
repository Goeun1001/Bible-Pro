//
//  Date.swift
//  Bible
//
//  Created by jge on 2020/08/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class Converter {
    func getNumber(number: String) -> String {
        var realNum: String = number
        if Int(number)! < 10 {
            realNum = "00" + number
        } else if Int(number)! > 9 && Int(number)! < 100 {
            realNum = "0" + number
        }
        return realNum
    }
    
    func getBibleName(bcode: String, cnum: String) -> String {
        let Eng = getBiblefromBcode(bcode: bcode)
        var realCnum: String = cnum
        if Int(cnum)! < 10 {
            realCnum = "_00" + cnum
        } else if Int(cnum)! > 9 && Int(cnum)! < 100 {
            realCnum = "_0" + cnum
        } else {
            realCnum = "_" + cnum
        }
        return Eng + realCnum
    }
    
    func getBiblefromBcode(bcode: String) -> String {
        switch bcode {
        case "1": return "Ge01"
        case "2": return "Ex02"
        case "3": return "Lev3"
        case "4": return "Nu04"
        case "5": return "Dt05"
        case "6": return "Jos6"
        case "7": return "Jdg7"
        case "8": return "ru08"
        case "9": return "1Sa9"
        case "10": return "2Sa0"
        case "11": return "1Ki1"
        case "12": return "2Ki2"
        case "13": return "2Ch3"
        case "14": return "2Ch1"
        case "15": return "Ezr5"
        case "16": return "Ne16"
        case "17": return "Est7"
        case "18": return "Job8"
        case "19": return "Ps19"
        case "20": return "Pr20"
        case "21": return "Ecc1"
        case "22": return "SS22"
        case "23": return "Isa3"
        case "24": return "Jer4"
        case "25": return "La25_001"
        case "26": return "Eze6"
        case "27": return "Da27"
        case "28": return "Hos8"
        case "29": return "Joel"
        case "30": return "Am30"
        case "31": return "Ob31"
        case "32": return "Jnh2"
        case "33": return "Mic3"
        case "34": return "Na34"
        case "35": return "Hab5"
        case "36": return "Zep6"
        case "37": return "Hag7"
        case "38": return "Zec8"
        case "39": return "Mal9"
        case "40": return "Mt40"
        case "41": return "Mk41"
        case "42": return "Lk42"
        case "43": return "Jn43"
        case "44": return "Ac44"
        case "45": return "Ro45"
        case "46": return "1Co6"
        case "47": return "2Co7"
        case "48": return "Gal8"
        case "49": return "Eph9"
        case "50": return "Php0"
        case "51": return "Col1"
        case "52": return "1Th2"
        case "53": return "2Th3"
        case "54": return "1Ti4"
        case "55": return "2Ti5"
        case "56": return "Tit6"
        case "57": return "Phm7"
        case "58": return "Heb8"
        case "59": return "Jas9"
        case "60": return "1Pe0"
        case "61": return "2Pe1"
        case "62": return "1Jn2"
        case "63": return "2Jn3"
        case "64": return "3Jn4"
        case "65": return "Jude"
        case "66": return "Rev6"
        default:
            print("Error: Can't convert Bible from Bcode\(bcode)")
            return ""
        }
        
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
