//
//  AppDelegate.swift
//  KynhongIOSBase
//
//  Created by Kynhong on 1/25/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            SceneManager.shared.config(window)
        }
//        NotificationManager.shared.config()
        self.installLibs()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
        SceneManager.shared.appDidBecomeActive()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
        SceneManager.shared.appWillResignActive()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
        SceneManager.shared.appDidEnterBackground()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
//        DeeplinkManager.shared.waitCheckTime = true
        SceneManager.shared.appWillEnterForeground()
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return DeeplinkManager.shared.openURL(url)
//    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        PermissionManager.shared.isRequestPermission = false
//        NotificationManager.shared.setAPNS(deviceToken: deviceToken)
//    }
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        PermissionManager.shared.isRequestPermission = false
//    }
    
    func installLibs() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}

