//
//  PlanetDTO.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import Foundation

struct PlanetDTO: Codable {
    let name: String
    
    static func mappedFrom(planet: Planet) -> PlanetDTO {
        PlanetDTO(
            name: planet.name
        )
    }
}
