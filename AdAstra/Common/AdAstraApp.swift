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
            Group {
                ZStack{
                    if session.isLoadingCurrentUser {
                        ProgressView()
                        
                    } else if session.isSignedIn {
                        NavigationStack {
                            UsersListView()
                        }
                        
                    } else {
                        SignInView()
                    }
                    
                    EasterEggView(easterEgg: $easterEgg)
                        .transition(.scale.combined(with: .blurReplace))
                        .opacity(easterEgg ? 1.0 : 0.0)
                }
            }
            .sensoryFeedback(.impact, trigger: easterEgg)
            .onTapGesture(count: 4) {
                print("Feito por Gustavinhos e Cia.")
                withAnimation{
                    easterEgg = true
                }
            }
            .environmentObject(session)
        }
    }
}
