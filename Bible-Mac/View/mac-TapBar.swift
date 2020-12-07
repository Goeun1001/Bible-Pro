//
//  SettingView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

//func showWindow() {
//    var window:NSWindow
//    window = NSWindow(
//        contentRect: NSRect(x: 0, y: 0, width: 800, height: 600),
//        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//        backing: .buffered, defer: false)
//    window.center()
//    window.contentView = NSHostingView(rootView: mac_SongList())
//    window.makeKeyAndOrderFront(nil)
//}

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
//                    showWindow()
                }
            }
        }
        //        VStack(spacing: 50) {
        //            NavigationLink(destination: mac_SongList()) {
        //                VStack {
        //                    Image("MusicBook")
        //                        .resizable()
        //                        .frame(width: 30, height: 30)
        //                    Text("찬송가")
        //                }
        //            }
        //
        //            NavigationLink(destination: mac_gyodokList()) {
        //                VStack {
        //                    Image("Book")
        //                        .resizable()
        //                        .frame(width: 30, height: 30)
        //                    Text("교독문")
        //
        //                }
        //            }
        //
        //            //            NavigationLink(destination: CCMVCtoUI()) {
        //            //                barView(imageName: "CCM", text: "CCM")
        //            //            }
        //
        //            NavigationLink(destination: mac_SettingView()) {
        //                VStack {
        //                    Image("Settings")
        //                        .resizable()
        //                        .frame(width: 30, height: 30)
        //                    Text("설정")
        //                }
        //            }
        //        }
    }
}

struct mac_TapBar_Previews: PreviewProvider {
    static var previews: some View {
        mac_TapBar()
    }
}
