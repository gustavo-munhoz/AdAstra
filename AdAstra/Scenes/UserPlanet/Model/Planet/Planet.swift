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

extension Planet {
    static var mock: Planet {
        Planet(
            name: "test-\(Int.random(in: 0..<100))",
            gradientName: GradientName.allCases.randomElement()!,
            textureName: TextureName.allCases.randomElement()!
        )
    }
}
