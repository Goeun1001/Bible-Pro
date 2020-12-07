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
    
    @State private var offset = CGSize.zero
    @State private var float = true
    @State var inline = false
    @State var ShareSheet = false
    
    let player = AVPlayer()
    @State var playing = false
    
    func playRadio() {
        player.play()
        //        player.playImmediately(atRate: 0.925)
    }
    
    func pauseRadio() {
        player.pause()
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                GeometryReader { _ in
                    List {
                        if UserDefaults.standard.bool(forKey: "purchased") {
                            HStack(spacing: 5) {
                                Image(systemName: playing ? "pause.circle" : "play.circle")
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
                        } else {
                            VStack(alignment: .center, spacing: -10) {
                                HStack(spacing: 5) {
                                    Image(systemName: playing ? "pause.circle" : "play.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    
                                    AudioPlayerControlsView(player: player,
                                                            timeObserver: PlayerTimeObserver(player: player),
                                                            durationObserver: PlayerDurationObserver(player: player),
                                                            itemObserver: PlayerItemObserver(player: player))
                                }.padding(.leading, 15)
                                .padding(.trailing, 15)
                            }.foregroundColor(.gray)
                        }
                        ForEach(self.verseVM.verses, id: \.id) { verse in
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
                                    
                                    if let popoverController = av.popoverPresentationController {
                                        popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                                        popoverController.sourceView = UIApplication.shared.windows.first?.rootViewController?.view
                                        popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                                    }
                                    
                                    //
                                    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                                }) {
                                    Text("Share")
                                    Image(systemName: "square.and.arrow.up")
                                }
                                Button(action: {
                                    verseVM.bookmark(id: Int(verse.vnum)!)
                                }) {
                                    Image(systemName: "heart.fill")
                                    Text("Bookmark")
                                }
                            }
                        }
                    }
                }.gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.offset = gesture.translation
                            if self.offset.height >= 0 {
                                withAnimation {
                                    self.float = true
                                }
                            } else if self.offset.height < 0 {
                                withAnimation {
                                    self.float = false
                                }
                            }
                        }
                )
                
                // MARK: Floating Bar
                if float {
                    HStack(alignment: .center) {
                        HStack {
                            NavigationLink(destination: SongListView()) {
                                barView(imageName: "MusicBook", text: "찬송가")
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: GyodokListView()) {
                                barView(imageName: "Book", text: "교독문")
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: CCMVCtoUI()) {
                                barView(imageName: "CCM", text: "CCM")
                            }.simultaneousGesture(TapGesture().onEnded {
                                self.inline = true
                            })
                            
                            Spacer()
                            
                            NavigationLink(destination: SettingView()) {
                                barView(imageName: "Settings", text: "설정")
                            }
                        }
                        .padding([.leading, .trailing], UIFrame.UIWidth / 10)
                    }.padding(.top, 10)
                    .padding(.bottom, 5)
                    .background(RoundedCorners(color: Color("Gray"), tl: 25, tr: 25, bl: 0, br: 0).shadow(radius: 3).edgesIgnoringSafeArea(.bottom))
                    .transition(.move(edge: .bottom))
                }
            }
            .onAppear {
                self.verseVM.getVerse()
                self.verseVM.getNum()
                self.inline = false
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
            .navigationBarTitle(Text("\(self.verseVM.bibleName.name) \(self.verseVM.verses.first?.cnum ?? "0")장"), displayMode: inline ? .inline : .automatic)
            .navigationBarItems(trailing:
                                    HStack(spacing: 20) {
                                        NavigationLink(destination: BibleListView()) {
                                            imageView(imageName: "burger", isSystem: false)
                                        }
                                        imageView(imageName: "arrowtriangle.left", isSystem: true)
                                            .onTapGesture {
                                                if Int(self.verseVM.verses.first!.cnum)! - 1 != 0 {
                                                    let minus = Int(self.verseVM.verses.first!.cnum)! - 1
                                                    UserDefaults.standard.set("\(minus)", forKey: "cnum")
                                                    UserDefaults.standard.synchronize()
                                                    self.verseVM.getVerse()
                                                    self.verseVM.getNum()
                                                    guard let url = URL(string: "https://bible.jeonggo.com/audio/\(self.verseVM.realNum).mp3") else {
                                                        return
                                                    }
                                                    let playerItem = AVPlayerItem(url: url)
                                                    self.player.volume = 2
                                                    self.player.replaceCurrentItem(with: playerItem)
                                                }
                                            }
                                        imageView(imageName: "arrowtriangle.right", isSystem: true)
                                            .onTapGesture {
                                                if Int(self.verseVM.verses.first!.cnum)! + 1 != self.verseVM.bibleName.chapter_count + 1 {
                                                    let plus = Int(self.verseVM.verses.first!.cnum)! + 1
                                                    UserDefaults.standard.set("\(plus)", forKey: "cnum")
                                                    UserDefaults.standard.synchronize()
                                                    self.verseVM.getVerse()
                                                    self.verseVM.getNum()
                                                    guard let url = URL(string: "https://bible.jeonggo.com/audio/\(self.verseVM.realNum).mp3") else {
                                                        return
                                                    }
                                                    let playerItem = AVPlayerItem(url: url)
                                                    self.player.volume = 2
                                                    self.player.replaceCurrentItem(with: playerItem)
                                                }
                                            }
                                    })
        }
        .accentColor(Color("Text"))
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct currentVerseView_Previews: PreviewProvider {
    static var previews: some View {
        VerseView()
    }
}

struct imageView: View {
    let imageName: String
    let isSystem: Bool
    var body: some View {
        VStack {
            if isSystem {
                Image(systemName: "\(imageName)")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("Text"))
            } else {
                Image(imageName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("Text"))
            }
        }
    }
}

struct barView: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(imageName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color("Text"))
            Text(text)
                .foregroundColor(Color("Text"))
            
        }
    }
}

