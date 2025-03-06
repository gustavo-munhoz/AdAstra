//
//  UsersListViewModel.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import UIKit

class UsersListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isFetchingUsers: Bool = true
    
    private let facade = UserPersistenceFacade.firebase()
    
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
        users.filterByRoles(.mentor, .jrMentor)
    }
    
    init(mock: Bool = false) {
        if mock {
            users = [.mock, .mock, .mock, .mock]
            return
        }
        
        Task {
            await MainActor.run { isFetchingUsers = true }
            
            let fetchedUsers = await facade.getAllUsers(sortedBy: {
                $0.name < $1.name
            })
            
            await MainActor.run {
                users = fetchedUsers
            }
            
            await MainActor.run { isFetchingUsers = false }
            
//            await loadUserImages()
        }
    }
    
//    private func loadUserImages() async {
//        let semaphore = AsyncSemaphore(permits: 20)
//        
//        await withTaskGroup(of: Void.self) { group in
//            for (index, user) in users.enumerated() where user.profilePicture == UIImage.defaultUserImage() {
//                group.addTask { [weak self] in
//                    guard let self = self else { return }
//                                        
//                    await semaphore.wait()
//                    
//                    let newImage = await self.facade.getUserProfilePicture(docId: user.id)
//                    let updatedUser = user.settingProfilePicture(to: newImage)
//                    
//                    await MainActor.run {
//                        self.users[index] = updatedUser
//                    }
//                                        
//                    await semaphore.signal()
//                }
//            }
//        }
//    }
    
    @MainActor func signOut(with session: SessionStore) {
        session.signOut()
    }
}
