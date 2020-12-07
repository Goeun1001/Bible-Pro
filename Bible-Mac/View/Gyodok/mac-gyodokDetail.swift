//
//  mac-gyodokDetail.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_gyodokDetail: View {
    let jang: Int
    let title: String
    
    var gyodokDetail: [Gyodok] { readGyodok("SELECT * FROM gyodok where jang = \(jang)")
    }
    
    var body: some View {
        
        List {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(gyodokDetail, id: \.self) { gyodok in
                    Text("\(gyodok.sojul). \(gyodok.note)")
                }
            }
        }
        .padding(.top, 20)
    }
}

struct mac_gyodokDetail_Previews: PreviewProvider {
    static var previews: some View {
        mac_gyodokDetail(jang: 1, title: "타이틀")
    }
}
