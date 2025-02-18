//
//  Role.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 18/02/25.
//

import Foundation

enum Role: String, CaseIterable, InitializableByString {
    case student, mentorJr, mentor
    
    var localized: String {
        NSLocalizedString(rawValue, comment: "")
    }
}
