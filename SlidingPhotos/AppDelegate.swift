//
//  AppDelegate.swift
//  SlidingTiles
//
//  Created by Alex Shum on 05/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var easyBoard: Board?
    var midBoard : Board? // Since both the Board View and the View Controller will want access to this object, let the AppDelegate object own it
    var hardBoard: Board?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.easyBoard = Board(dim: 3)
        self.easyBoard!.scramble(numSwap: 200)
        self.midBoard = Board(dim: 4)
        self.midBoard!.scramble(numSwap: 200)
        self.hardBoard = Board(dim: 5)
        self.hardBoard!.scramble(numSwap: 200)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

