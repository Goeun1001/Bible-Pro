//
//  VerseViewModel.swift
//  Bible
//
//  Created by jge on 2020/11/20.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var verses = [Verse]()
    @Published var bibleName: Bible = Bible(id: 0, vcode: "", bcode: 0, type: "", name: "", chapter_count: 0)
    
    init() {
        getVerse()
    }
    
    func getVerse() {
        let bcode = UserDefaults.standard.value(forKey: "bcode") as! String
        let vcode = UserDefaults.standard.value(forKey: "vcode") as! String
//        var type = UserDefaults.standard.value(forKey: "type") as! String
        let cnum = UserDefaults.standard.value(forKey: "cnum") as! String
        self.verses = readVerses("SELECT * FROM verses where bcode = '\(bcode)' AND cnum = '\(cnum)' AND vcode = '\(vcode)'")
        
        getBibleName()
    }
    
    func getBibleName() {
        let bcode = UserDefaults.standard.value(forKey: "bcode") as! String
        let vcode = UserDefaults.standard.value(forKey: "vcode") as! String
        self.bibleName = readBibles("SELECT * FROM bibles where vcode = '\(vcode)' AND bcode = '\(bcode)'").first!
    }
}
