//
//  GyodokDetailView.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct GyodokDetailView: View {
    let jang: Int
    let title: String
    
    var gyodokDetail: [Gyodok] { readGyodok("SELECT * FROM gyodok where jang = \(jang)")
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(gyodokDetail, id: \.self) { gyodok in
                    Text("\(gyodok.sojul). \(gyodok.note)")
                }
            }.frame(width: UIFrame.UIWidth - 40)
        }
        .padding(.top, 20)
        .navigationBarTitle(Text(title), displayMode: .inline)
    }
}

struct GyodokDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GyodokDetailView(jang: 1, title: "타이틀")
    }
}
