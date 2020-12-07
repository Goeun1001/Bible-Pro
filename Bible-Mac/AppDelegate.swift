//
//  AppDelegate.swift
//  AllDevices-macOS
//
//  Created by jge on 2020/07/23.
//  Copyright © 2020 jge. All rights reserved.
//

import Cocoa
import SwiftUI
import StoreKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    var songWindow: NSWindow!
    var imageWindow: NSWindow!
    var settingWindow: NSWindow!
    var gyodokWindow: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        
        // MARK: DB download
        
        let fileManager = FileManager.default
        
        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let finalDatabaseURL = documentsUrl.appendingPathComponent("holybible.db")
        
        do {
            if !fileManager.fileExists(atPath: finalDatabaseURL.path) {
                print("DB does not exist in documents folder")
                if let dbFilePath = Bundle.main.path(forResource: "holybible", ofType: "db") {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: finalDatabaseURL.path)
                    setUp()
                    
                } else {
                    print("Uh oh - foo.db is not in the app bundle")
                }
            } else {
                print("Database file found at path: \(finalDatabaseURL.path)")
            }
        } catch {
            print("Unable to copy foo.db: \(error)")
        }
        
        
        
        // MARK: View Appear
        
        let contentView = ContentView()
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 900, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func openSongWindow() {
        if nil == songWindow {
            let songView = mac_SongView()
            // Create the preferences window and set content
            songWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 900, height: 600),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false)
            songWindow.center()
                            songWindow.setFrameAutosaveName("songView")
            songWindow.isReleasedWhenClosed = false
            songWindow.contentView = NSHostingView(rootView: songView)
        }
        songWindow.makeKeyAndOrderFront(nil)
    }
    
    @objc func openImageWindow() {
        let imageView = mac_ImageView()
        // Create the preferences window and set content
        imageWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 900, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false)
        imageWindow.center()
        imageWindow.setFrameAutosaveName("imageView")
        imageWindow.isReleasedWhenClosed = false
        imageWindow.contentView = NSHostingView(rootView: imageView)
        imageWindow.makeKeyAndOrderFront(nil)
    }
    
    @objc func openSettingView() {
        if nil == settingWindow {
            let settingView = mac_SettingView()
            // Create the preferences window and set content
            settingWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 300, height: 300),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false)
            settingWindow.center()
            settingWindow.setFrameAutosaveName("settingView")
            settingWindow.isReleasedWhenClosed = false
            settingWindow.contentView = NSHostingView(rootView: settingView)
        }
        settingWindow.makeKeyAndOrderFront(nil)
    }
    
    @objc func openGyodokView() {
        if nil == gyodokWindow {
            let gyodokView = mac_GyodokView()
            // Create the preferences window and set content
            gyodokWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 900, height: 600),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false)
            gyodokWindow.center()
            gyodokWindow.setFrameAutosaveName("gyodokView")
            gyodokWindow.isReleasedWhenClosed = false
            gyodokWindow.contentView = NSHostingView(rootView: gyodokView)
        }
        gyodokWindow.makeKeyAndOrderFront(nil)
    }
    
}

func setUp() {
    UserDefaults.standard.set("GAE", forKey: "vcode")
    UserDefaults.standard.set("old", forKey: "type")
    UserDefaults.standard.set(0, forKey: "selectedIndex")
    UserDefaults.standard.synchronize()
}
