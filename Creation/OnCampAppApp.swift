//
//  OnCampAppApp.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/8/23.
//

import SwiftUI
import FirebaseCore
import Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct OnCampAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userData = UserData()
    @StateObject var postData = PostData()
    var body: some Scene {
        WindowGroup {
           if Auth.auth().currentUser != nil {
                        tabBar()
                .environmentObject(userData)
                   .environmentObject(postData)
                        // User is authenticated, show the main app content
                  } else {
                        Landing()
                        // User is not authenticated, show a login/signup view
                       
            }
                }
            
        }
    }

