//
//  mac-SongDetail.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import AVFoundation

struct mac_SongDetail: View {
    
    let player = AVPlayer()
    @State var playing = false
    
    func playRadio() {
        player.play()
    }
    
    func pauseRadio() {
        player.pause()
    }
    
    var number: String
    var name: String
    
    var realNum: String {
        Converter().getNumber(number: number)
    }
    
    var body: some View {
        //        ScrollVi ew {
        VStack(spacing: 10) {
            Text("\(number)장 \(name)")
                .font(.title)
                .padding(.bottom, 20)
            
            Image("\(realNum)")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 400, minHeight: 400)
                .onTapGesture {
                    UserDefaults.standard.set(realNum, forKey: "image")
                    UserDefaults.standard.synchronize()
                    NSApp.sendAction(#selector(AppDelegate.openImageWindow), to: nil, from: nil)
                }
            
            HStack(spacing: 5) {
                Image(playing ? "pause" : "play")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        if self.playing == false {
                            self.playRadio()
                        }
                        if self.playing == true {
                            self.pauseRadio()
                        }
                        self.playing.toggle()
                    }
                AudioPlayerControlsView(player: player,
                                        timeObserver: PlayerTimeObserver(player: player),
                                        durationObserver: PlayerDurationObserver(player: player),
                                        itemObserver: PlayerItemObserver(player: player))
            }.padding(.leading, 15)
            .padding(.trailing, 15)
        }.padding(.top, 20)
        .padding(.bottom, 20)
        .onAppear {
            guard let url = URL(string: "https://bible.jeonggo.com/\(self.realNum).mp3") else {
                return
            }
            let playerItem = AVPlayerItem(url: url)
            self.player.replaceCurrentItem(with: playerItem)
        }
        .onDisappear {
            self.player.replaceCurrentItem(with: nil)
        }
    }
}

struct mac_SongDetail_Previews: PreviewProvider {
    static var previews: some View {
        mac_SongDetail(number: "1", name: "찬송가 1")
    }
}
