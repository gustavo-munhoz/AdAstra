//
//  PlanetDTO.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import Foundation

enum PlanetMappingError: Error {
    case invalidGradientName
    case invalidTextureName
}

struct PlanetDTO: Codable {
    // MARK: - Attributes
    let name: String
    let gradientName: String
    let textureName: String
    
    // MARK: - Mapping Methods
    
    func mappedToPlanet() throws -> Planet {
        guard let gradientName = GradientName.fromString(gradientName) else {
            throw PlanetMappingError.invalidGradientName
        }
        
        guard let textureName = TextureName.fromString(textureName) else {
            throw PlanetMappingError.invalidTextureName
        }
        
        return Planet(
            name: name,
            gradientName: gradientName,
            textureName: textureName
        )
    }
    
    static func mappedFrom(planet: Planet) -> PlanetDTO {
        PlanetDTO(
            name: planet.name,
            gradientName: planet.gradientName.rawValue,
            textureName: planet.textureName.rawValue
        )
    }
}
