//
//  SceneDelegate.swift
//  Bible
//
//  Created by jge on 2020/08/05.
//  Copyright © 2020 jge. All rights reserved.
//

import UIKit
import SwiftUI
import StoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
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
        
        let contentView = VerseView()
        //        let contentView = ContentView()
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            //            window.rootViewController = UIHostingController(rootView: contentView)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(storeManager))
            self.window = window
            window.makeKeyAndVisible()
        }
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
