//
//  UserPlanetViewModel.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import Foundation

enum UserConnectionError: Error, LocalizedError {
    case incorrectKeyword
    
    var errorDescription: String? {
        NSLocalizedString("Incorrect keyword!", comment: "")
    }
}

class UserPlanetViewModel: ObservableObject {
    
    @Published var user: User
    @Published var keywordInput: String = ""
    @Published var errorMessage: String? = nil
    
    init(user: User) {
        self.user = user
    }
    
    func connectToUser(session: SessionStore) throws(UserConnectionError) {
        guard keywordInput.isEqualIgnoringCaseAndWhitespace(user.connectionPassword) else {
            throw .incorrectKeyword
        }
        
        Task { await session.registerUserConnection(with: user) }
    }
}
