//
//  UserLoginApp.swift
//  UserLogin
//
//  Created by Reenad gh on 27/05/1444 AH.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(.noData)
            return
        }
        // This notification is not auth related, developer should handle it.
    }
}

@main
struct UserLoginApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var firebaseUserManager : FirebaseUserManager = FirebaseUserManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(firebaseUserManager)
                
        }
    }
}
