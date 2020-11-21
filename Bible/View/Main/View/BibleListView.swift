//
//  BibleList.swift
//  Bible
//
//  Created by jge on 2020/08/06.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct BibleListView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @State private var dismissAll: Bool = false
    
    @ObservedObject private var bibleVM = MainViewModel()
    
    var body: some View {
        List((bibleVM.isOld == "old") ? bibleVM.oldBibles : bibleVM.newBibles, id: \.id) { bible in
            NavigationLink(destination: NumberListView(dismissAll: self.$dismissAll, bcode: bible.bcode, chapter_num: bible.chapter_count, name: bible.name)) {
                HStack {
                    Text(bibleVM.isOld == "old" ? String(bible.bcode) : String(bible.bcode - 39))
                    Text(bible.name)
                    Spacer()
                    Text("총 \(bible.chapter_count)장")
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
            }
            .onAppear {
                if self.dismissAll == true {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("\(bibleVM.bibleStatus)성경 선택", displayMode: .automatic)
            .navigationBarItems(trailing:
                HStack(spacing: 20) {
                    Text("구약")
                        .foregroundColor(bibleVM.isOld == "old" ? Color("Text") : .gray)
                        .onTapGesture(count: 1) {
//                            self.isOld = "old"
                            UserDefaults.standard.set("old", forKey: "type")
                            UserDefaults.standard.synchronize()
                            bibleVM.getBibles()
                    }
                    Text("신약")
                        .foregroundColor(bibleVM.isOld == "old" ? .gray : Color("Text"))
                        .onTapGesture(count: 1) {
//                            self.isOld = "new"
                            UserDefaults.standard.set("new", forKey: "type")
                            UserDefaults.standard.synchronize()
                            bibleVM.getBibles()
                    }
            })
        }
    }
}

struct BibleListView_Previews: PreviewProvider {
    static var previews: some View {
        BibleListView()
    }
}
