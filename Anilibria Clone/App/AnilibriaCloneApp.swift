//
//  AnilibriaCloneApp.swift
//  AnilibriaClone
//
//  Created by Мурад on 23/7/24.
//

import SwiftUI
@main
struct AnilibriaCloneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AnilibriaCloneTabBarView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    static var orientation: UIInterfaceOrientationMask = .portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return Self.orientation
    }
}
