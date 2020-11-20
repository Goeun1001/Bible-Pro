//
//  DataModel.swift
//  Bible
//
//  Created by jge on 2020/11/20.
//  Copyright © 2020 jge. All rights reserved.
//

struct Bible: Hashable, Codable, Identifiable {
    var id: Int
    var vcode: String
    var bcode: Int
    var type: String
    var name: String
    var chapter_count: Int
    
    init(id: Int, vcode: String, bcode: Int, type: String, name: String, chapter_count: Int) {
        self.id = id
        self.vcode = vcode
        self.bcode = bcode
        self.type = type
        self.name = name
        self.chapter_count = chapter_count
    }
}

struct Verse: Hashable, Codable, Identifiable {
    var id: Int
    var vcode: String
    var bcode: Int
    var cnum: String
    var vnum: String
    var content: String
    var bookmarked: Int
    
    init(id: Int, vcode: String, bcode: Int, cnum: String, vnum: String, content: String, bookmarked: Int) {
        self.id = id
        self.vcode = vcode
        self.bcode = bcode
        self.cnum = cnum
        self.vnum = vnum
        self.content = content
        self.bookmarked = bookmarked
    }
}

struct Daily: Hashable, Codable, Identifiable {
    
    var id: Int
    var bible: String
    var content: String
    
    init(id: Int, bible: String, content: String) {
        self.id = id
        self.bible = bible
        self.content = content
    }
    
}

struct Gyodok: Hashable, Codable, Identifiable {
    var id: Int
    var jang: Int
    var title: String
    var sojul: Int
    var note: String
    
    init(id: Int, jang: Int, title: String, sojul: Int, note: String) {
        self.id = id
        self.jang = jang
        self.title = title
        self.sojul = sojul
        self.note = note
    }
}

struct Song: Hashable, Codable, Identifiable {
    var id: Int
    var version: String
    var type: String
    var number: String
    var title: String
    
    init(id: Int, version: String, type: String, number: String, title: String) {
        self.id = id
        self.version = version
        self.type = type
        self.number = number
        self.title = title
    }
}
