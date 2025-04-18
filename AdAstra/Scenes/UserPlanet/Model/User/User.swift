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
    let shift: String
    let role: String
}

struct User: Identifiable, Equatable {
    
    // MARK: - Attributes
    let id: String
    let name: String
    let age: Int
    let course: String
    let shift: Shift
    let role: Role
    let interests: String
    let pronouns: String
    let connectionPassword: String
    let connectionCount: Int
    let connectedUsers: [UserSummary]
    let secretFact: String
    
//    var profilePicture: UIImage!
    let profilePictureURL: URL?
    let planet: Planet
    
    // MARK: - Methods
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.connectionPassword == rhs.connectionPassword
//        && lhs.profilePicture == rhs.profilePicture
    }
    
    func hasSamePassword(as user: User) -> Bool {
        connectionPassword == user.connectionPassword
    }
    
    func getFormattedAge() -> String {
        if age == 0 { return "??" }
        
        return age.formatted()
    }
    
    func summary() -> UserSummary {
        UserSummary(
            name: name,
            connectionPassword: connectionPassword,
            shift: shift.rawValue,
            role: role.rawValue
        )
    }
    
    func isConnected(to user: User) -> Bool {
        !canConnect(to: user)
    }
    
    func canConnect(to user: User) -> Bool {
        guard !user.hasSamePassword(as: self) else { return false }
        
        return !connectedUsers.contains {
            $0.name == user.name
            && $0.connectionPassword == user.connectionPassword
        }
    }
    
    func addingConnection(with user: User) -> User {
        let newConnectionCount = connectionCount + 1
        let newConnectedUsers = connectedUsers + [user.summary()]
        
        return User(
            id: id,
            name: name,
            age: age,
            course: course,
            shift: shift,
            role: role,
            interests: interests,
            pronouns: pronouns,
            connectionPassword: connectionPassword,
            connectionCount: newConnectionCount,
            connectedUsers: newConnectedUsers,
            secretFact: secretFact,
            profilePictureURL: profilePictureURL,
            planet: planet
        )
    }
    
//    func settingProfilePicture(to image: UIImage) -> User {
//        User(
//            id: id,
//            name: name,
//            age: age,
//            course: course,
//            shift: shift,
//            role: role,
//            interests: interests,
//            pronouns: pronouns,
//            connectionPassword: connectionPassword,
//            connectionCount: connectionCount,
//            connectedUsers: connectedUsers,
//            secretFact: secretFact,
//            profilePicture: image,
//            planet: planet
//        )
//    }
}

extension User {
    static var mock: User {
        User(
            id: UUID().uuidString,
            name: "user-\(Int.random(in: 0..<100))",
            age: Int.random(in: 18..<100),
            course: "test",            
            shift: .afternoon,
            role: .mentor,
            interests: "test",
            pronouns: "test",
            connectionPassword: "test",
            connectionCount: Int.random(in: 0..<100),
            connectedUsers: [],
            secretFact: "test",
//            profilePicture: .defaultUserImage(),
            profilePictureURL: URL(string: "")!,
            planet: .mock
        )
    }
}
