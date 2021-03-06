//
//  currentVerseView.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//
import SwiftUI
import StoreKit
import AVFoundation

struct VerseView: View {
    @ObservedObject private var verseVM = MainViewModel()
    @State var verses = [Verse]()
    var bcode: Int
    var cnum: Int
    
    @State private var offset = CGSize.zero
    @State private var float = true
    
    let player = AVPlayer()
    @State var playing = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                GeometryReader { _ in
                    List {
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
                        
                        ForEach(self.verses, id: \.id) { verse in
                            HStack {
                                VStack {
                                    Text(verse.vnum)
                                    Spacer()
                                }
                                Text(verse.content)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            //                            .contextMenu {
                            //                                Button(action: {
                            //                                    let text = verse.content
                            //                                    let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
                            //
                            //                                    if let popoverController = av.popoverPresentationController {
                            //                                        popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                            //                                        popoverController.sourceView = UIApplication.shared.windows.first?.rootViewController?.view
                            //                                        popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                            //                                    }
                            //
                            //                                    //
                            //                                    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                            //                                }) {
                            //                                    Text("Share")
                            //                                    Image(systemName: "square.and.arrow.up")
                            //                                }
                            //                                Button(action: {
                            //                                    verseVM.bookmark(id: Int(verse.vnum)!)
                            //                                }) {
                            //                                    Image("heart")
                            //                                    Text("Bookmark")
                            //                                }
                            //                            }
                        }.frame(maxHeight: .infinity)
                    }
                }
            }
            .onAppear {
                let vcode = UserDefaults.standard.value(forKey: "vcode") as! String
                self.verses = readVerses("SELECT * FROM verses where bcode = '\(self.bcode)' AND cnum = '\(self.cnum)' AND vcode = '\(vcode)'")
                //                self.verseVM.getVerse()
                self.verseVM.getNum()
                guard let url = URL(string: "https://bible.jeonggo.com/audio/\(self.verseVM.realNum).mp3") else {
                    return
                }
                let playerItem = AVPlayerItem(url: url)
                self.player.volume = 2
                self.player.replaceCurrentItem(with: playerItem)
            }
            .onDisappear {
                self.player.replaceCurrentItem(with: nil)
            }
        }
    }
    func playRadio() {
        player.play()
    }
    
    func pauseRadio() {
        player.pause()
    }
}

struct currentVerseView_Previews: PreviewProvider {
    static var previews: some View {
        VerseView(bcode: 1, cnum: 1)
    }
}
