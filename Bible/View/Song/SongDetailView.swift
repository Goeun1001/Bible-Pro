//
//  SongDetailView.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct SongDetailView: View {
    var number: String
    var name: String
    
    var realNum: String {
        DateConverter().getNumber(number: number)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("\(number)장 \(name)")
                    .font(.title)
                    .padding(.bottom, 20)
                
                NavigationLink(destination: SongImageView(number: realNum)) {
                    Image("\(realNum)")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .shadow(radius: 5)
                }
            }.padding(.top, 20)
                .padding(.bottom, 20)
        }.navigationBarTitle(Text("\(self.number)장 \(self.name)"), displayMode: .inline)
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailView(number: "1", name: "찬송가 1")
    }
}
