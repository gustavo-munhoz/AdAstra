//
//  UserDTO.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import Foundation

struct UserDTO: Codable {
    let uid: String
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
}
