//
//  mac-GyodokView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_GyodokView: View {
    var body: some View {
        NavigationView {
            mac_gyodokList()
                .frame(minWidth:200, maxWidth: 200)
        }
    }
}

struct mac_GyodokView_Previews: PreviewProvider {
    static var previews: some View {
        mac_GyodokView()
    }
}
