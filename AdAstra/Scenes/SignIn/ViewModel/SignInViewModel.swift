//
//  SignInViewModel.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    
    @Published var userConnectionPassword: String = ""
    @Published var isFetchingUser: Bool = false
    @Published var foundUser: User?
    @Published var errorMessage: String?
    
    func fetchUser() {
        let facade = UserPersistenceFacade.firebase()
        
        Task {
            await MainActor.run { isFetchingUser = true }
            
            do {
                let user = try await facade.getUserFromConnectionPassword(
                    userConnectionPassword
                        .lowercased()
                )
                
                await MainActor.run {
                    self.foundUser = user
                    self.errorMessage = nil
                }
            } catch {
                print(error.localizedDescription)
                
                await MainActor.run {
                    self.foundUser = nil
                    self.errorMessage = error.localizedDescription
                }
            }
            
            await MainActor.run { isFetchingUser = false }
        }
    }
    
    @MainActor func confirmSignIn(with session: SessionStore) {
        guard let foundUser else {
            print("foundUser missing in SignInViewModel")
            return
        }
        
        session.signIn(user: foundUser)
    }
}
