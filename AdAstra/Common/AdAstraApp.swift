//
//  AdAstraApp.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}

@main
struct AdAstraApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var session = SessionStore()
    
    @State var easterEgg: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if session.isLoadingCurrentUser {
                    LoadingView(loadingText: "Initializing...")
                    
                } else if session.isSignedIn {
                    NavigationStack {
                        UsersListView()
                    }
                    .transition(.opacity)
                    
                } else {
                    SignInView()
                        .transition(.opacity)
                }
            }
            .environmentObject(session)
        }
    }
}
