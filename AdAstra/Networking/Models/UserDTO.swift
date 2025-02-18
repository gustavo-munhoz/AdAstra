//
//  UserDTO.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import UIKit

enum UserMappingError: Error {
    case invalidShift
    case invalidRole
    case invalidPlanet
}

struct UserDTO: Codable {
    // MARK: - Attributes
    var docId: String?
    
    let name: String
    let age: Int
    let course: String
    let institution: String
    let shift: String
    let role: String
    let interests: Set<String>
    let pronouns: String
    let connectionPassword: String
    let connectionCount: Int
    let connectedUsers: [UserSummary]
    let secretFact: String
    
    let profilePictureURL: URL?
    let planet: PlanetDTO
    
    enum CodingKeys: String, CodingKey {
        case name, age, course, institution, shift, role, interests, pronouns
        case connectionPassword, connectionCount, connectedUsers, secretFact
        case profilePictureURL, planet
    }
    
    // MARK: - Mapping Methods
    
    func mappedToUser(withImage image: UIImage) throws -> User {
        guard let docId else {
            throw FirestoreError.missingDocumentId
        }
        
        guard let userRole = Role.fromString(role) else {
            throw UserMappingError.invalidRole
        }
        
        guard let userShift = Shift.fromString(shift) else {
            throw UserMappingError.invalidShift
        }
        
        guard let planet = try? planet.mappedToPlanet() else {
            throw UserMappingError.invalidPlanet
        }
        
        return User(
            id: docId,
            name: name,
            age: age,
            course: course,
            institution: institution,
            shift: userShift,
            role: userRole,
            interests: interests,
            pronouns: pronouns,
            connectionPassword: connectionPassword,
            connectionCount: connectionCount,
            connectedUsers: connectedUsers,
            secretFact: secretFact,
            profilePicture: image,
            planet: planet
        )
    }
    
    static func mappedFrom(user: User, imageURL: URL?) -> UserDTO {
        UserDTO(
            docId: user.id,
            name: user.name,
            age: user.age,
            course: user.course,
            institution: user.institution,
            shift: user.shift.rawValue,
            role: user.role.rawValue,
            interests: user.interests,
            pronouns: user.pronouns,
            connectionPassword: user.connectionPassword,
            connectionCount: user.connectionCount,
            connectedUsers: user.connectedUsers,
            secretFact: user.secretFact,
            profilePictureURL: imageURL,
            planet: .mappedFrom(planet: user.planet)
        )
    }
}
