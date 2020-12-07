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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        
        let fileManager = FileManager.default
        
        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let finalDatabaseURL = documentsUrl.appendingPathComponent("holybible.db")
        
        do {
            if !fileManager.fileExists(atPath: finalDatabaseURL.path) {
                print("DB does not exist in documents folder")
                if let dbFilePath = Bundle.main.path(forResource: "holybible", ofType: "db") {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: finalDatabaseURL.path)
                    
                } else {
                    print("Uh oh - foo.db is not in the app bundle")
                }
            } else {
                print("Database file found at path: \(finalDatabaseURL.path)")
            }
        } catch {
            print("Unable to copy foo.db: \(error)")
        }
        
        setUp()
        
        let storeManager = StoreManager()
        
        SKPaymentQueue.default().add(storeManager)
        storeManager.getProducts(productIDs: ["Audio_payment"])
        
        let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
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

}

func setUp() {
    UserDefaults.standard.set("GAE", forKey: "vcode")
    UserDefaults.standard.set("1", forKey: "bcode")
    UserDefaults.standard.set("1", forKey: "cnum")
    UserDefaults.standard.set("old", forKey: "type")
    UserDefaults.standard.set(0, forKey: "selectedIndex")
    UserDefaults.standard.synchronize()
}
