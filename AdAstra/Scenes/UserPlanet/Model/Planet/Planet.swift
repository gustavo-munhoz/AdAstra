//
//  Planet.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import Foundation

struct Planet {
    let name: String
    let gradientName: GradientName
    let textureName: TextureName
}

enum GradientName: String, CaseIterable, InitializableByString {
    case turquoise
    case green
    case yellow
    case red
    case pink
    case purple
    case blue
    case black
    case white
}

enum TextureName: String, CaseIterable, InitializableByString {
    case rectangles, circles, triangles
}

extension Planet {
    static var mock: Planet {
        Planet(
            name: "test-\(Int.random(in: 0..<100))",
            gradientName: .white,
            textureName: .rectangles
        )
    }
}
