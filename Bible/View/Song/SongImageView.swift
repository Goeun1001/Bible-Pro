//
//  SongImageView.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct SongImageView: View {
    var number: String
    @GestureState var scale: CGFloat = 1.0
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    var body: some View {
        
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(number)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading, 1)
                    .padding(.trailing, 1)
                    .scaleEffect(scale)
                    .pinchToZoom()
                    .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                    .gesture(DragGesture()
                        .onChanged { value in
                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                    }
                    .onEnded { value in
                        self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                        self.newPosition = self.currentPosition
                        }
                )
            }
        }
    }
}

struct SongImageView_Previews: PreviewProvider {
    static var previews: some View {
        SongImageView(number: "1")
    }
}
