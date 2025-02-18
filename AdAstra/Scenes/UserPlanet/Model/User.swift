//
//  User.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import UIKit

struct UserSummary: Codable {
    let name: String
    let connectionPassword: String
}

struct User: Identifiable, Equatable {
    let id: String
    let name: String
    let course: String
    let institution: String
    let shift: String
    let interests: Set<String>
    let pronouns: String
    let connectionPassword: String
    let connectionCount: Int
    let connectedUsers: [UserSummary]
    let secretFact: String
    
    let profilePicture: UIImage
    let planet: Planet
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.connectionPassword == rhs.connectionPassword
    }
    
    func summary() -> UserSummary {
        UserSummary(
            name: name,
            connectionPassword: connectionPassword
        )
    }
    
    func canConnect(to user: User) -> Bool {
        guard user != self else { return false }
        
        return !connectedUsers.contains(where: {
            $0.name == user.name
            && $0.connectionPassword == user.connectionPassword
        })
    }
    
    func addingConnection(with user: User) -> User {
        let newConnectionCount = connectionCount + 1
        let newConnectedUsers = connectedUsers + [user.summary()]
        
        return User(
            id: id,
            name: name,
            course: course,
            institution: institution,
            shift: shift,
            interests: interests,
            pronouns: pronouns,
            connectionPassword: connectionPassword,
            connectionCount: newConnectionCount,
            connectedUsers: newConnectedUsers,
            secretFact: secretFact,
            profilePicture: profilePicture,
            planet: planet
        )
    }
}
