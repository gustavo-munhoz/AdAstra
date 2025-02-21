//
//  GradientName.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 18/02/25.
//

import UIKit

enum GradientName: String, CaseIterable, InitializableByString {
    case turquoise = "planetTurquoise"
    case green = "planetGreen"
    case yellow = "planetYellow"
    case red = "planetRed"
    case pink = "planetPink"
    case purple = "planetPurple"
    case blue = "planetBlue"
    case black = "planetBlack"
    case white = "planetWhite"
    
    var gradientColors: [UIColor] {
        switch self {
        case .turquoise:
            [.gradientTurquoise1, .gradientTurquoise2]
        case .green:
            [.gradientGreen1, .gradientGreen2]
        case .yellow:
            [.gradientYellow1, .gradientYellow2]
        case .red:
            [.gradientRed1, .gradientRed2]
        case .pink:
            [.gradientPink1, .gradientPink2]
        case .purple:
            [.gradientPurple1, .gradientPurple2]
        case .blue:
            [.gradientBlue1, .gradientBlue2]
        case .black:
            [.gradientBlack1, .gradientBlack2]
        case .white:
            [.gradientWhite1, .gradientWhite2]
        }
    }
}
