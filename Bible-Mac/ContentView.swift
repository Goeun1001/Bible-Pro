//
//  ContentView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/03.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            mac_TapBar()
                .frame(maxWidth: 60)
            NavigationView {
                mac_BibleListView()
            }
        }.frame(minWidth: 900, minHeight: 600)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
