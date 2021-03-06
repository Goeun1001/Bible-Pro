//
//  VerseViewModel.swift
//  Bible
//
//  Created by jge on 2020/11/20.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import StoreKit

class MainViewModel: ObservableObject {
    @Published var verses = [Verse]()
    @Published var bibleName: Bible = Bible(id: 0, vcode: "", bcode: 0, type: "", name: "", chapter_count: 0)
    @Published var oldBibles = [Bible]()
    @Published var newBibles = [Bible]()
    
    @Published var isOld = ""
    @Published var bibleStatus = ""
    
    @Published  var realNum = ""
    
    init() {
        getVerse()
        getBibles()
    }
    
    func getBibles() {
        let vcode = UserDefaults.standard.value(forKey: "vcode") as! String
        self.oldBibles = readBibles("SELECT * FROM bibles where vcode = '\(vcode)' AND type = 'old'")
        self.newBibles = readBibles("SELECT * FROM bibles where vcode = '\(vcode)' AND type = 'new'")
        
        self.isOld = UserDefaults.standard.value(forKey: "type") as! String
        self.bibleStatus = (isOld == "old") ? "구약" : "신약"
    }
    
    func getVerse() {
        let bcode = UserDefaults.standard.value(forKey: "bcode") as! String
        let vcode = UserDefaults.standard.value(forKey: "vcode") as! String
        let cnum = UserDefaults.standard.value(forKey: "cnum") as! String
        self.verses = readVerses("SELECT * FROM verses where bcode = '\(bcode)' AND cnum = '\(cnum)' AND vcode = '\(vcode)'")
        #if os(OSX)
        getBibleName()
        #endif
    }
    
    func getNum() {
        let bcode = UserDefaults.standard.value(forKey: "bcode") as! String
        let cnum = UserDefaults.standard.value(forKey: "cnum") as! String
        self.realNum = Converter().getBibleName(bcode: bcode, cnum: cnum)
    }
    
    func getBibleName() {
        let bcode = UserDefaults.standard.value(forKey: "bcode") as! String
        let vcode = UserDefaults.standard.value(forKey: "vcode") as! String
        self.bibleName = readBibles("SELECT * FROM bibles where vcode = '\(vcode)' AND bcode = '\(bcode)'").first!
    }
    
    func bookmark(id: Int) {
        let bcode = UserDefaults.standard.value(forKey: "bcode") as! String
        let vcode = UserDefaults.standard.value(forKey: "vcode") as! String
        let cnum = UserDefaults.standard.value(forKey: "cnum") as! String
        updateBookmark("UPDATE verses set bookmarked = 1 where vnum = \(id) AND bcode = '\(bcode)' AND cnum = '\(cnum)' AND vcode = '\(vcode)'")
    }
    
    func unBookmark(id: Int) {
        let bcode = UserDefaults.standard.value(forKey: "bcode") as! String
        let vcode = UserDefaults.standard.value(forKey: "vcode") as! String
        let cnum = UserDefaults.standard.value(forKey: "cnum") as! String
        updateBookmark("UPDATE verses set bookmarked = 0 where vnum = \(id) AND bcode = '\(bcode)' AND cnum = '\(cnum)' AND vcode = '\(vcode)'")
    }
    
}
