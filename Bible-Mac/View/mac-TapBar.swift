//
//  SettingView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct tabbar: Hashable, Codable {
    var image: String
    var text: String
}

struct mac_TapBar: View {
    let tabs = [tabbar(image: "MusicBook", text: "찬송가"), tabbar(image: "Book", text: "교독문"), tabbar(image: "Settings", text: "설정")]
    var body: some View {
        List {
            ForEach(0...2, id: \.self) { i in
                VStack {
                    Image(tabs[i].image)
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text(tabs[i].text)
                }.onTapGesture {
                    if i == 0 { NSApp.sendAction(#selector(AppDelegate.openSongWindow), to: nil, from:nil) }
                    if i == 1 { NSApp.sendAction(#selector(AppDelegate.openGyodokView), to: nil, from:nil) }
                    if i == 2 { NSApp.sendAction(#selector(AppDelegate.openSettingView), to: nil, from:nil) }
                }
            }
        }
    }
}

struct mac_TapBar_Previews: PreviewProvider {
    static var previews: some View {
        mac_TapBar()
    }
}

