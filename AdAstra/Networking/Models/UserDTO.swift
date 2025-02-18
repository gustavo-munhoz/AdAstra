//
//  UserDTO.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import Foundation

struct UserDTO: Codable {
    var docId: String?
    
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
    
    let profilePictureURL: URL?
    let planet: PlanetDTO
    
    enum CodingKeys: String, CodingKey {
        case name, course, institution, shift, interests, pronouns
        case connectionPassword, connectionCount, connectedUsers, secretFact
        case profilePictureURL, planet
    }
    
    static func mappedFrom(user: User, imageURL: URL?) -> UserDTO {
        UserDTO(
            docId: user.id,
            name: user.name,
            course: user.course,
            institution: user.institution,
            shift: user.shift,
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
