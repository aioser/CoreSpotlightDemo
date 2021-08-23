//
//  AppDelegate.swift
//  CoreSpotlightDemo
//
//  Created by sama 刘 on 2021/8/20.
//

import UIKit
import CoreSpotlight

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        debugPrint(launchOptions)
        return true
    }
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if (userActivity.activityType == CSSearchableItemActionType) {
            let id = userActivity.userInfo?[CSSearchableItemActivityIdentifier]
            debugPrint("userActivity id = \(id)")
        }
        return true
    }
}

