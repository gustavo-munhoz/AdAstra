//
//  UserPlanetViewModel.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import Foundation

enum UserConnectionError: Error {
    case incorrectKeyword
}

class UserPlanetViewModel: ObservableObject {
    
    let user: User
    
    @Published var keywordInput: String = ""
    
    init(user: User) {
        self.user = user
    }
    
    func connectToUser(_ user: User, session: SessionStore) throws(UserConnectionError) {
        guard keywordInput.isEqualIgnoringCaseAndWhitespace(user.connectionPassword) else {
            throw .incorrectKeyword
        }
        
        Task { await session.registerUserConnection(with: user) }
    }
}
