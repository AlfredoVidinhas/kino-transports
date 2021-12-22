//
//  kino_transportsApp.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 15/11/2021.
//

import SwiftUI
import Firebase

@main
struct kino_transportsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("log_Status") var status = false
    
    var body: some Scene {
        WindowGroup {
            if status{
                HomeView()
            }
            else{
                SplashView()
            }
        }
    }
}

// init FireBase

class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification
                     userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler:
                     @escaping (UIBackgroundFetchResult) -> Void) {
    }
}
