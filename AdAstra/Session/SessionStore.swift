//
//  SessionStore.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 15/02/25.
//

import Foundation

@MainActor final class SessionStore: ObservableObject {
    
    private let facade: UserPersistenceFacade = .firebase()
    
    @Published var currentUser: User? {
        didSet {
            UserDefaults.standard.set(
                currentUser?.connectionPassword,
                forKey: "connectionPassword"
            )
        }
    }
    
    @Published var isLoadingCurrentUser: Bool = true
    
    var isSignedIn: Bool {
        currentUser != nil
    }
    
    init() {
        guard let connectionPassword = UserDefaults.standard.string(
            forKey: "connectionPassword"
        ) else {
            isLoadingCurrentUser = false
            return
        }
        
        Task {
            do {
                await MainActor.run { isLoadingCurrentUser = true }
                
                let user = try await facade.getUserFromConnectionPassword(connectionPassword)
                
                self.currentUser = user
                
                await MainActor.run { isLoadingCurrentUser = false }
                
            } catch {
                print(error.localizedDescription)
                self.currentUser = nil
            }
        }
    }
    
    func registerUserConnection(with user: User) {
        guard let currentUser, currentUser.canConnect(to: user) else { return }
        
        self.currentUser = currentUser.addingConnection(with: user)
        
        Task { try await facade.updateUser(self.currentUser!) }
    }
    
    func signIn(user: User) {
        currentUser = user
    }
    
    func signOut() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "connectionPassword")
    }
}
