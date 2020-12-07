//
//  mac-ImageView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//


import SwiftUI

struct mac_ImageView: View {
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
//                    .pinchToZoom()
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

struct mac_ImageView_Previews: PreviewProvider {
    static var previews: some View {
        mac_ImageView(number: "1")
    }
}
