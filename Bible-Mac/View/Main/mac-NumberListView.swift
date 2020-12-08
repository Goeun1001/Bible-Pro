//
//  mac-NumberListView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_NumberListView: View {
    var bcode: Int
    var chapter_num: Int
    var name: String
    
    var body: some View {
        NavigationView {
            List {
                ForEach(1..<chapter_num+1, id: \.self) { number in
                    NavigationLink(destination: VerseView(bcode: self.bcode, cnum: number)) {
                        VStack(alignment: .center) {
                            Text(String(number)+"장")
                        }.padding([.all], 5)
                    }
                }
            }.frame(minWidth: 60, maxWidth: 60)
            
        }
    }
}

struct mac_NumberListView_Previews: PreviewProvider {
    static var previews: some View {
        mac_NumberListView(bcode: 1, chapter_num: 30, name: "창세기")
    }
}
