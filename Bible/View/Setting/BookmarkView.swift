//
//  BookmarkView.swift
//  Bible
//
//  Created by jge on 2020/11/22.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct BookmarkView: View {
    @State var verses = [Verse]()
    @ObservedObject private var verseVM = MainViewModel()
    
    var body: some View {
        List {
            ForEach(self.verses, id: \.id) { verse in
                HStack {
                    VStack(alignment: .leading) {
                        Text(verse.content)
                        HStack {
                            if UserDefaults.standard.value(forKey: "vcode") as! String == "NIV" {
                                Text(englishBibles[verse.bcode - 1])
                                    .fixedSize(horizontal: true, vertical: false)
                            } else {
                                Text(koreaBibles[verse.bcode - 1])
                                    .fixedSize(horizontal: true, vertical: false)
                            }
                            Text("\(verse.cnum)장")
                            Text("\(verse.vnum)절")
                        }.foregroundColor(.gray)
                    }
                    Spacer()
                    ZStack(alignment: .center) {
                        Circle().foregroundColor(.red)
                        Image(systemName: "minus").foregroundColor(.white)
                    }.frame(width: 18, height: 18)
                    .onTapGesture {
                        verseVM.unBookmark(id: Int(verse.vnum)!)
                        withAnimation {
                            self.read()
                        }
                    }
                    
                }.padding([.top, .bottom], 5)
                .contextMenu {
                    Button(action: {
                        let text = verse.content
                        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
                        
                        if let popoverController = av.popoverPresentationController {
                                popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                            popoverController.sourceView = UIApplication.shared.windows.first?.rootViewController?.view
                                popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                            }
                        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                    }) {
                        Text("Share")
                        Image(systemName: "square.and.arrow.up")
                    }
                    Button(action: {
                        verseVM.unBookmark(id: Int(verse.vnum)!)
                        withAnimation {
                            self.read()
                        }
                    }) {
                        Image(systemName: "heart.fill")
                        Text("unBookmark")
                    }
                }
            }
        }.listStyle(GroupedListStyle())
        .onAppear {
            self.read()
        }
    }
    
    func read() {
        self.verses = readVerses("SELECT * FROM verses where bookmarked = 1")
    }
}

//struct BookmarkView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkView()
//    }
//}

let koreaBibles = ["창세기", "출애굽기", "레위기", "민수기", "신명기", "여호수아", "사사기", "룻기", "사무엘상", "사무엘하", "열왕기상", "열왕기하", "역대상", "역대하", "에스라", "느헤미야", "에스더", "욥기", "시편", "잠언", "전도서", "아가", "이사야", "예레미야", "예레미야 애가", "에스겔", "다니엘", "호세아", "요엘", "아모스", "오바댜", "요나", "미가", "나훔", "하박국", "스바냐", "학개", "스가랴", "말라기", "마태복음", "마가복음", "누가복음", "요한복음", "사도행전", "로마서", "고린도전서", "고린도후서", "갈라디아서", "에베소서", "빌립보서", "골로새서", "데살로니가전서", "데살로니가후서", "디모데전서", "디모데후서", "디도서", "빌레몬서", "히브리서", "야고보서", "베드로전서", "베드로후서", "요한1서", "요한2서", "요한3서", "유다서", "요한계시록"]

let englishBibles = ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs", "Ecclesiastes", "Song of Songs", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi", "Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galantians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation"]
