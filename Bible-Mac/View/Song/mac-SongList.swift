//
//  mac-SongView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_SongList: View {
    @State var search: String = ""
    @State var isSearching = false
    
    var songSearching: [Song] {
        readSong("SELECT * FROM hymns where title LIKE '%\(String(search.components(separatedBy: ["장"]).joined()))%' OR _id LIKE '%\(String(search.components(separatedBy: ["장"]).joined()))%'")
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("search")
                    .resizable()
                    .frame(width: 10, height: 10)
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
            List(isSearching ? songSearching : songSearching, id: \.id) { song in
                NavigationLink(destination: mac_SongDetail(number: song.number, name: song.title)) {
                    Text("\(song.number)장 \(song.title)")
                }
            }
        }
    }
}

struct mac_SongList_Previews: PreviewProvider {
    static var previews: some View {
        mac_SongList()
    }
}
