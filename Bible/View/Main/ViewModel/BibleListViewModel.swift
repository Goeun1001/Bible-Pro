//
//  ContentViewModel.swift
//  Bible
//
//  Created by jge on 2020/08/06.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

class BibleListViewModel: ObservableObject {
    
    @Published var oldbibles = [RealmBible]()
    @Published var newBibles = [RealmBible]()
    @Published var bcode = UserDefaults.standard.value(forKey: "bcode") as! String
    @Published var vcode = UserDefaults.standard.value(forKey: "vcode") as! String
    @Published var type = UserDefaults.standard.value(forKey: "type") as! String
    
    init() {
        getBible()
    }
    
    func getBible() {
        self.oldbibles = RealmManager.shared.getBibleLists(vcode: self.vcode, type: "old")
        self.newBibles = RealmManager.shared.getBibleLists(vcode: self.vcode, type: "new")
    }
}
