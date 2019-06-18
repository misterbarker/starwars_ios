//
//  AppDelegate.swift
//  StarWars
//
//  Created by Jason Barker on 6/15/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initCache()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) { }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
    
    // MARK: -
    
    private func initCache() {
        let memory = 1024 * 1024 * 512
        let disk = 1024 * 1024 * 512
        URLCache.shared = URLCache(memoryCapacity: memory, diskCapacity: disk, diskPath: nil)
    }
}

