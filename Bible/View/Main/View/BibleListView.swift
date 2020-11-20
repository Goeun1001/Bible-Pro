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
    
    @State private var isOld = UserDefaults.standard.value(forKey: "type") as! String
    @State private var vcode = UserDefaults.standard.value(forKey: "vcode") as! String
    
    var body: some View {
        List((vcode == "GAE") ? ((isOld == "old") ? oldBibleData : newBibleData) : ((isOld == "old") ? oldEngBibleData : newEngBibleData), id: \.id) { bible in
            NavigationLink(destination: NumberListView(dismissAll: self.$dismissAll, bcode: bible.bcode, chapter_num: bible.chapter_count, name: bible.name)) {
                HStack {
                    Text(self.isOld == "old" ? String(bible.bcode) : String(bible.bcode - 39))
//                        .font(.custom("NanumSquareL", size: 25))
                    Text(bible.name)
//                        .font(.custom("NanumSquareEB", size: 25))
                    Spacer()
                    Text("총 \(bible.chapter_count)장")
//                        .font(.custom("NanumSquareL", size: 20))
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
            }
            .onAppear {
                if self.dismissAll == true {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationBarTitle("성경 선택", displayMode: .inline)
            .navigationBarItems(trailing:
                HStack(spacing: 20) {
                    Text("구약")
                        .foregroundColor(self.isOld == "old" ? (self.colorScheme == .dark ? .white : .black) : .gray)
                        .onTapGesture {
                            self.isOld = "old"
                            UserDefaults.standard.set("old", forKey: "type")
                            UserDefaults.standard.synchronize()
                    }
                    Text("신약")
                        .foregroundColor(self.isOld == "old" ? .gray : (self.colorScheme == .dark ? .white : .black))
                        .onTapGesture {
                            self.isOld = "new"
                            UserDefaults.standard.set("new", forKey: "type")
                            UserDefaults.standard.synchronize()
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
