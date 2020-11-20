//
//  currentBibleViewModel.swift
//  Bible
//
//  Created by jge on 2020/08/10.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Combine

class VerseViewModel: ObservableObject, ViewModelType {
    
    typealias InputType = Input
    
    private var cancellables: [AnyCancellable] = []
    private var vcode: String = ""
    private var bcode: String = ""
    private var cnum: String = ""
    
    // MARK: Input
    enum Input {
        case onAppear
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            UserDefaults.standard.synchronize()
            self.vcode = UserDefaults.standard.value(forKey: "vcode") as! String
            self.bcode = UserDefaults.standard.value(forKey: "bcode") as! String
            self.cnum = UserDefaults.standard.value(forKey: "cnum") as! String
            onAppearSubject.send(())
        }
    }
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    
    // MARK: Output
    
    @Published var markedverses = [RealmVerse]()
    @Published var verses = [RealmVerse]()
    @Published var bibleName = RealmBible()
    
    private let responseSubject = PassthroughSubject<[RealmVerse], Never>()
    private let bibleResponseSubject = PassthroughSubject<RealmBible, Never>()
    private let errorSubject = PassthroughSubject<RealmError, Never>()
    
    private let realmManager: RealmManager
    
    init(realmManager: RealmManager = RealmManager()) {
        self.realmManager = realmManager
        bindInputs()
        bindOutputs()
        UserDefaults.standard.set(true, forKey: "isChanged")
        UserDefaults.standard.synchronize()
    }
    
    private func bindInputs() {
        
        let responsePublisher = onAppearSubject
            .flatMap { [realmManager] _ in
                realmManager.getCustomBible(vcode: self.vcode, bcode: self.bcode, cnum: self.cnum)
                    .catch { [weak self] error -> Empty<[RealmVerse], Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }
        
        let bibleResponsePublisher = onAppearSubject
            .flatMap { [realmManager] _ in
                realmManager.getNamefrombcode(vcode: self.vcode, bcode: self.bcode)
                    .catch { [weak self] error -> Empty<RealmBible, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }
        
        let responseStream = responsePublisher
            .share()
            .subscribe(responseSubject)
        
        let bibleResponseStream = bibleResponsePublisher
            .share()
            .subscribe(bibleResponseSubject)
        
        cancellables += [
            responseStream,
            bibleResponseStream
        ]
    }
    
    private func bindOutputs() {
        
        let repositoriesStream = responseSubject
            .map { $0 }
            .assign(to: \.verses, on: self)
        
        let bibleNameStream = bibleResponseSubject
            .map { $0 }
            .assign(to: \.bibleName, on: self)
        
        //        print("bindOutputs.assign")
        
        cancellables += [
            repositoriesStream,
            bibleNameStream
        ]
        
    }
    
    func LikeChange(id: Int, bool: Bool) {
        RealmManager.shared.writeBookmarked(id: id, bool: bool)
        self.verses = RealmManager.shared.getVerse(vcode: self.vcode, bcode: self.bcode, cnum: self.cnum)
    }
    
    func getBookmarked() {
        UserDefaults.standard.synchronize()
        self.vcode = UserDefaults.standard.value(forKey: "vcode") as! String
        self.markedverses = RealmManager.shared.getBookmarkedVerse(vcode: self.vcode)
    }
    
    func LikeChange(id: Int) {
        UserDefaults.standard.synchronize()
        self.vcode = UserDefaults.standard.value(forKey: "vcode") as! String
        RealmManager.shared.writeBookmarked(id: id, bool: false)
        self.markedverses = RealmManager.shared.getBookmarkedVerse(vcode: self.vcode)
    }
    
}
