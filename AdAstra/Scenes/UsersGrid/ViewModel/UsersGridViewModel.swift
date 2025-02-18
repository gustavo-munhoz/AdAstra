//
//  UsersGridViewModel.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import Foundation
import UIKit

class UsersGridViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isFetchingUsers: Bool = false
    
    init(mock: Bool = false) {
        guard !mock else {
            users = [
                User(
                    id: "teste",
                    name: "teste",
                    course: "teste",
                    institution: "teste",
                    shift: "teste",
                    interests: ["teste"],
                    pronouns: "teste",
                    connectionPassword: "teste",
                    connectionCount: 13,
                    connectedUsers: [],
                    secretFact: "teste",
                    profilePicture: UIImage(),
                    planet: Planet(name: "pika")
                ), User(
                    id: "teste2",
                    name: "massa",
                    course: "teste",
                    institution: "teste",
                    shift: "teste",
                    interests: ["teste"],
                    pronouns: "teste",
                    connectionPassword: "teste",
                    connectionCount: 13,
                    connectedUsers: [],
                    secretFact: "teste",
                    profilePicture: UIImage(),
                    planet: Planet(name: "pika")
                ), User(
                    id: "teste3",
                    name: "carambolas",
                    course: "teste",
                    institution: "teste",
                    shift: "teste",
                    interests: ["teste"],
                    pronouns: "teste",
                    connectionPassword: "teste",
                    connectionCount: 13,
                    connectedUsers: [],
                    secretFact: "teste",
                    profilePicture: UIImage(),
                    planet: Planet(name: "pika")
                ), User(
                    id: "teste4",
                    name: "pirulitu",
                    course: "teste",
                    institution: "teste",
                    shift: "teste",
                    interests: ["teste"],
                    pronouns: "teste",
                    connectionPassword: "teste",
                    connectionCount: 13,
                    connectedUsers: [],
                    secretFact: "teste",
                    profilePicture: UIImage(),
                    planet: Planet(name: "pika")
                )]
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
