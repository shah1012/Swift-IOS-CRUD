//
//  Firebase_IOS_AppApp.swift
//  Firebase IOS App
//
//  Created by Dax C Shah on 10/25/21.
//

import SwiftUI
import Firebase

final class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions:[UIApplication.LaunchOptionsKey : Any]? = nil) ->
        Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Firebase_IOS_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    //create a state object for our session service
    @StateObject var sessionService = SessionServiceImpl()
    
    var body: some Scene {
        WindowGroup {
            
            NavigationView{
                switch sessionService.state{
                    case .loggedIn:
                        HomeView()
                        .environmentObject(sessionService)//display details
                    case .loggedOut:
                        LogInView()
                }
            }
        }
    }
}
