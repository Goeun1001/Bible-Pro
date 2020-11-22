//
//  BookmarkView.swift
//  Bible
//
//  Created by jge on 2020/11/22.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct BookmarkView: View {
    @State var verses: [Verse]
    
    var body: some View {
        List {
            ForEach(self.verses, id: \.id) { verse in
                HStack {
                    VStack {
                        Text(verse.vnum)
                        Spacer()
                    }
                    Text(verse.content)
                }.contextMenu {
                    Button(action: {
                        let text = verse.content
                        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                    }) {
                        Text("Share")
                        Image(systemName: "square.and.arrow.up")
                    }
                    Button(action: {
                        
                    }) {
                        Image(systemName: "heart.fill")
                        Text("Bookmark")
                    }
                }
            }
        }.onAppear() {
            
        }
    }
}

//struct BookmarkView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkView()
//    }
//}
