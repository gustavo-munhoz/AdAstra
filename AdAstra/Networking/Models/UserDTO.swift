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
    let bio: String
    let connectionPassword: String
    let connectionCount: Int
    let secretFact: String
    
    let profilePictureURL: URL?
    let planet: PlanetDTO
    
    enum CodingKeys: String, CodingKey {
        case name, course, institution, shift, interests, bio
        case connectionPassword, connectionCount, secretFact
        case profilePictureURL, planet
    }
}
