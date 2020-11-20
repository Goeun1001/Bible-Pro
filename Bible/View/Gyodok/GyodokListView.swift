//
//  gyodokListView.swift
//  Bible
//
//  Created by jge on 2020/08/11.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct GyodokListView: View {
    @State var search: String = ""
    @State var isSearching = false
    
    var gyodokSearching: [Gyodok] { readGyodok("SELECT * FROM gyodok where title LIKE '%\(search)%' AND sojul = 1")
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
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
                NavigationLink(destination: GyodokDetailView(jang: gyodok.jang, title: gyodok.title)) {
                    Text(gyodok.title)
                }
            }
        }.navigationBarTitle(Text("교독문"), displayMode: .inline)
    }
}

struct gyodokListView_Previews: PreviewProvider {
    static var previews: some View {
        GyodokListView()
    }
}
