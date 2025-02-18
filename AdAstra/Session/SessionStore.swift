//
//  SessionStore.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 15/02/25.
//

import Foundation

@MainActor final class SessionStore: ObservableObject {
    
    @Published var currentUser: User? {
        didSet {
            UserDefaults.standard.set(
                currentUser?.connectionPassword,
                forKey: "connectionPassword"
            )
        }
    }
    
    @Published var isLoadingCurrentUser: Bool = false
    
    var isSignedIn: Bool {
        currentUser != nil
    }
    
    init() {
        guard let connectionPassword = UserDefaults.standard.string(
            forKey: "connectionPassword"
        ) else { return }
        
        Task {
            await MainActor.run { isLoadingCurrentUser = true }
            
            let facade = UserPersistenceFacade.firebase()
            let user = try? await facade.getUserFromConnectionPassword(connectionPassword)
            
            self.currentUser = user
            
            await MainActor.run { isLoadingCurrentUser = false }
        }
    }
    
    func signIn(user: User) {
        currentUser = user
    }
    
    func signOut() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "connectionPassword")
    }
}
