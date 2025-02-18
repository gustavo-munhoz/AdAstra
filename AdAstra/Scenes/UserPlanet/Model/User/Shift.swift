//
//  Shift.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 18/02/25.
//

import Foundation

enum Shift: String, CaseIterable, InitializableByString {
    case morning, afternoon
    
    var localized: String {
        NSLocalizedString(rawValue, comment: "")
    }
}
