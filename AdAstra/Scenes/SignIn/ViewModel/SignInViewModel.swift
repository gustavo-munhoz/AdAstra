//
//  SignInViewModel.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import Foundation
import SwiftUI

class SignInViewModel: ObservableObject {
    
    @Published var userConnectionPassword: String = ""
    @Published var isFetchingUser: Bool = false
    @Published var foundUser: User?
    @Published var errorMessage: String?
    
    func signIn() {
        let facade = UserPersistenceFacade.firebase()
        
        Task {
            await MainActor.run { isFetchingUser = true }
            
            do {
                let user = try await facade.getUserFromConnectionPassword(
                    userConnectionPassword
                        .replacingOccurrences(of: " ", with: "")
                        .lowercased()
                )
                
                await MainActor.run {
                    withAnimation{
                        self.foundUser = user
                        self.errorMessage = nil
                    }
                }
            } catch {
                print(error.localizedDescription)
                
                await MainActor.run {
                    withAnimation{
                        self.foundUser = nil
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
            
            await MainActor.run { isFetchingUser = false }
        }
    }
}
