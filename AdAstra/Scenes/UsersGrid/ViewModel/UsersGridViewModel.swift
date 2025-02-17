//
//  UsersGridViewModel.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import Foundation

class UsersGridViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isFetchingUsers: Bool = false
    
    init() {
        let facade = UserPersistenceFacade.firebase()
        
        Task {
            await MainActor.run { isFetchingUsers = true }
            
            let fetchedUsers = await facade.getAllUsers(sortedBy: {
                $0.name < $1.name
            })
            
            await MainActor.run {
                users = fetchedUsers
            }
            
            await MainActor.run { isFetchingUsers = false }
        }
    }
    
    @MainActor func signOut(with session: SessionStore) {
        session.signOut()
    }
}
