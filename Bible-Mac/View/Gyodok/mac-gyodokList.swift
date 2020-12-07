//
//  mac-gyodokList.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_gyodokList: View {
    @State var search: String = ""
    @State var isSearching = false
    
    var gyodokSearching: [Gyodok] { readGyodok("SELECT * FROM gyodok where title LIKE '%\(search)%' AND sojul = 1")
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("search")
                TextField("Search", text: $search, onEditingChanged: { changed in
                    if changed == false {
                        if self.search == "" {
                            self.isSearching = false
                        } else {
                            self.isSearching = true
                        }
                    }
                }).textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.top, 10)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            List(isSearching ? gyodokSearching : gyodokData, id: \.id) { gyodok in
                NavigationLink(destination: mac_gyodokDetail(jang: gyodok.jang, title: gyodok.title)) {
                    Text(gyodok.title)
                }
            }
        }
    }
}

struct gyodokListView_Previews: PreviewProvider {
    static var previews: some View {
        mac_gyodokList()
    }
}
