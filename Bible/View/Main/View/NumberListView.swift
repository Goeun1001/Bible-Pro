//
//  NumberListView.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct NumberListView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @Binding var dismissAll: Bool
    
    var bcode: Int
    var chapter_num: Int
    var name: String
    
    var body: some View {
        WaterfallGrid(1..<chapter_num + 1, id: \.self) { number in
            numberGridView(text: String(number))
            .onTapGesture {
                UserDefaults.standard.set("\(self.bcode)", forKey: "bcode")
                UserDefaults.standard.set("\(number)", forKey: "cnum")
//                UserDefaults.standard.set(true, forKey: "isChanged")
                UserDefaults.standard.synchronize()
                self.presentationMode.wrappedValue.dismiss()
                self.dismissAll = true
            }
        }.gridStyle(columns: 4, spacing: 10)
            .padding(.leading, 25)
            .padding(.trailing, 25)
            .padding(.top, 20)
            .navigationBarTitle(name)
    }
}

struct NumberListView_Previews: PreviewProvider {
    static var previews: some View {
        NumberListView(dismissAll: .constant(false), bcode: 1, chapter_num: 30, name: "창세기")
    }
}

struct numberGridView: View {
    var text: String
    
    var body: some View {
        Text(text)
        .font(.headline)
        .foregroundColor(.black)
            .frame(width: 40)
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color("LightGray")))
    }
}
