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
    
    var body: some Scene {
        WindowGroup {
            Group {
                if session.isLoadingCurrentUser {
                    ProgressView()
                    
                } else if session.isSignedIn {
                    NavigationStack {
//                        UsersGridView()
                        UsersListView()
                    }
                    
                } else {
                    SignInView()
                }
            }
            .onTapGesture(count: 3) {
                print("Feito por Gustavinhos e Cia.")
            }
            .environmentObject(session)
        }
    }
}
