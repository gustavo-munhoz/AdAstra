//
//  UsersListViewModel.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import Foundation
import UIKit

class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isFetchingUsers: Bool = false
    
    var morningStudents: [User] {
        users
            .filterByShifts(.morning)
            .filterByRoles(.student)
    }
    
    var afternoonStudents: [User] {
        users
            .filterByShifts(.afternoon)
            .filterByRoles(.student)
    }
    
    var mentors: [User] {
        users.filterByRoles(.mentor, .mentorJr)
    }
    
    init(mock: Bool = false) {
        if mock {
            users = [.mock, .mock, .mock, .mock]
            return
        }
        
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
