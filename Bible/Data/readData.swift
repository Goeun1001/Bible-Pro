//
//  readData.swift
//  Bible
//
//  Created by jge on 2020/11/20.
//  Copyright © 2020 jge. All rights reserved.
//

import UIKit
import SwiftUI
import SQLite3

let oldBibleData: [Bible] = readBibles("SELECT * FROM bibles where vcode = 'GAE' AND type = 'old'") 
let oldEngBibleData: [Bible] = readBibles("SELECT * FROM bibles where vcode = 'NIV' AND type = 'old'")
let newBibleData: [Bible] = readBibles("SELECT * FROM bibles where vcode = 'GAE' AND type = 'new'")
let newEngBibleData: [Bible] = readBibles("SELECT * FROM bibles where vcode = 'NIV' AND type = 'new'")
let gyodokData: [Gyodok] = readGyodok("SELECT * FROM gyodok where sojul = 1")
let songData: [Song] = readSong("SELECT * FROM hymns")

let dailyData: [Daily] = readDaily("SELECT * FROM todaybible")

func readContent(bcode: Int, cnum: Int) -> [Verse] {
    
    let bibleContent: [Verse] = readVerses("SELECT vnum, content FROM verses where vcode = 'GAE' AND bcode = '\(bcode)' AND cnum = '\(cnum)'")
    return bibleContent
    
}

func readBibles(_ queryString: String) -> [Bible] {
    
    var bibleList = [Bible]()
    
    var db: OpaquePointer?
    
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("holybible.db")
    
    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
        print("error opening database")
    }
    
    bibleList.removeAll()
    
    var stmt: OpaquePointer?
    
    if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert: \(errmsg)")
        //        return
    }
    
    while sqlite3_step(stmt) == SQLITE_ROW {
        let id = sqlite3_column_int(stmt, 0)
        let vcode = String(cString: sqlite3_column_text(stmt, 1))
        let bcode = sqlite3_column_int(stmt, 2)
        let type = String(cString: sqlite3_column_text(stmt, 3))
        let name = String(cString: sqlite3_column_text(stmt, 4))
        let chapter_count = sqlite3_column_int(stmt, 5)
        
        bibleList.append(Bible(id: Int(id), vcode: String(describing: vcode), bcode: Int(bcode), type: String(describing: type), name: String(describing: name), chapter_count: Int(chapter_count)))
    }
    
    return bibleList
    
}

func readVerses(_ queryString: String) -> [Verse] {
    
    var VerseList = [Verse]()
    
    var db: OpaquePointer?
    
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("holybible.db")
    
    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
        print("error opening database")
    }
    
    VerseList.removeAll()
    
    var stmt: OpaquePointer?
    
    if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert: \(errmsg)")
    }
    
    while sqlite3_step(stmt) == SQLITE_ROW {
        let id = sqlite3_column_int(stmt, 0)
        let vcode = String(cString: sqlite3_column_text(stmt, 1))
        let bcode = sqlite3_column_int(stmt, 2)
        let cnum = String(cString: sqlite3_column_text(stmt, 3))
        let vnum = String(cString: sqlite3_column_text(stmt, 4))
        let content = String(cString: sqlite3_column_text(stmt, 5))
        let bookmarked = sqlite3_column_int(stmt, 6)
        
        VerseList.append(Verse(id: Int(id), vcode: String(describing: vcode), bcode: Int(bcode), cnum: String(describing: cnum), vnum: String(describing: vnum), content: String(describing: content), bookmarked: Int(bookmarked)))
    }
    
    return VerseList
    
}

func readDaily(_ queryString: String) -> [Daily] {
    
    var dailyList = [Daily]()
    
    var db: OpaquePointer?
    
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("holybible.db")
    
    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
        print("error opening database")
    }
    
    dailyList.removeAll()
    
    var stmt: OpaquePointer?
    
    if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert: \(errmsg)")
    }
    
    while sqlite3_step(stmt) == SQLITE_ROW {
        let id = sqlite3_column_int(stmt, 0)
        let bible = String(cString: sqlite3_column_text(stmt, 1))
        let content = String(cString: sqlite3_column_text(stmt, 2))
        
        dailyList.append(Daily(id: Int(id), bible: String(describing: bible), content: String(describing: content)))
    }
    
    return dailyList
    
}

func readGyodok(_ queryString: String) -> [Gyodok] {
    
    var gyodokList = [Gyodok]()
    
    var db: OpaquePointer?
    
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("holybible.db")
    
    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
        print("error opening database")
    }
    
    gyodokList.removeAll()
    
    var stmt: OpaquePointer?
    
    if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert: \(errmsg)")
    }
    
    while sqlite3_step(stmt) == SQLITE_ROW {
        let id = sqlite3_column_int(stmt, 0)
        let jang = sqlite3_column_int(stmt, 1)
        let title = String(cString: sqlite3_column_text(stmt, 2))
        let sojul = sqlite3_column_int(stmt, 3)
        let note = String(cString: sqlite3_column_text(stmt, 4))
        
        gyodokList.append(Gyodok(id: Int(id), jang: Int(jang), title: String(describing: title), sojul: Int(sojul), note: String(describing: note)))
    }
    
    return gyodokList
    
}

func readSong(_ queryString: String) -> [Song] {
    
    var songList = [Song]()
    
    var db: OpaquePointer?
    
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        .appendingPathComponent("holybible.db")
    
    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
        print("error opening database")
    }
    
    songList.removeAll()
    
    var stmt: OpaquePointer?
    
    if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert: \(errmsg)")
    }
    
    while sqlite3_step(stmt) == SQLITE_ROW {
        let id = sqlite3_column_int(stmt, 0)
        let version = String(cString: sqlite3_column_text(stmt, 1))
        let type = String(cString: sqlite3_column_text(stmt, 2))
        let number = String(cString: sqlite3_column_text(stmt, 3))
        let title = String(cString: sqlite3_column_text(stmt, 4))
        
        songList.append(Song(id: Int(id), version: String(describing: version), type: String(describing: type), number: String(describing: number), title: String(describing: title)))
    }
    
    return songList
    
}

func getNumber(number: String) -> String {
    var realNum: String = number
    if Int(number)! < 10 {
        realNum = "00" + number
    } else if Int(number)! > 9 && Int(number)! < 100 {
        realNum = "0" + number
    }
    
    return realNum
    
}

let days = getRealDays()

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
