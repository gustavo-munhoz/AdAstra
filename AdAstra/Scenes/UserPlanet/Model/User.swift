//
//  User.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import UIKit

struct User {
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
    let profilePicture: UIImage
}
