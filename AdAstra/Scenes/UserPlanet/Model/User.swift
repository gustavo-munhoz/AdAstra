//
//  User.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import UIKit

struct User: Identifiable {
    let id: String
    let name: String
    let course: String
    let institution: String
    let shift: String
    let interests: Set<String>
    let pronouns: String
    let connectionPassword: String
    let connectionCount: Int
    let connectedUsers: [User]
    let secretFact: String

    let profilePicture: UIImage
    let planet: Planet
}
