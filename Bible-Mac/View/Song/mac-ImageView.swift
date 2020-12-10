//
//  mac-ImageView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_ImageView: View {
    var number: String = UserDefaults.standard.value(forKey: "image") as! String
    
    let maxScale: CGFloat = 3.0
    let minScale: CGFloat = 1.0
    
    @State var lastValue: CGFloat = 1.0
    @State var scale: CGFloat = 1.0
    @State var draged: CGSize = .zero
    @State var prevDraged: CGSize = .zero
    @State var tapPoint: CGPoint = .zero
    @State var isTapped: Bool = false
    
    var body: some View {
        let magnify = MagnificationGesture(minimumScaleDelta: 0.2)
            .onChanged { value in
                let resolvedDelta = value / self.lastValue
                self.lastValue = value
                let newScale = self.scale * resolvedDelta
                self.scale = min(self.maxScale, max(self.minScale, newScale))
        }
        
        let gestureDrag = DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged { (value) in
                self.tapPoint = value.startLocation
                self.draged = CGSize(width: value.translation.width + self.prevDraged.width,
                                     height: value.translation.height + self.prevDraged.height)
        }
        GeometryReader { geo in
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image(number)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .animation(.default)
                        .offset(self.draged)
                        .scaleEffect(self.scale)
                        .gesture(
                            TapGesture(count: 2).onEnded({
                                self.isTapped.toggle()
                                if self.scale > 1 {
                                    self.scale = 1
                                } else {
                                    self.scale = 2
                                }
                                let parent = geo.frame(in: .local)
                                self.postArranging(translation: CGSize.zero, in: parent)
                            })
                            .simultaneously(with: gestureDrag.onEnded({ (value) in
                                let parent = geo.frame(in: .local)
                                self.postArranging(translation: value.translation, in: parent)
                            })
                        ))
                        .gesture(magnify.onEnded { _ in
                            // without this the next gesture will be broken
                            self.lastValue = 1.0
                            let parent = geo.frame(in: .local)
                            self.postArranging(translation: CGSize.zero, in: parent)
                        })
                }
            }
        }
    }
    
    private func postArranging(translation: CGSize, in parent: CGRect) {
        let scaled = self.scale
        let parentWidth = parent.maxX
        let parentHeight = parent.maxY
        let offset = CGSize(width: (parentWidth * scaled - parentWidth) / 2,
                            height: (parentHeight * scaled - parentHeight) / 2)
        
        print(offset)
        var resolved = CGSize()
        let newDraged = CGSize(width: self.draged.width * scaled,
                               height: self.draged.height * scaled)
        if newDraged.width > offset.width {
            resolved.width = offset.width / scaled
        } else if newDraged.width < -offset.width {
            resolved.width = -offset.width / scaled
        } else {
            resolved.width = translation.width + self.prevDraged.width
        }
        if newDraged.height > offset.height {
            resolved.height = offset.height / scaled
        } else if newDraged.height < -offset.height {
            resolved.height = -offset.height / scaled
        } else {
            resolved.height = translation.height + self.prevDraged.height
        }
        self.draged = resolved
        self.prevDraged = resolved
    }
}

struct mac_ImageView_Previews: PreviewProvider {
    static var previews: some View {
        mac_ImageView(number: "1")
    }
}
