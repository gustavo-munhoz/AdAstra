//
//  PlanetViewModelStore.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 21/02/25.
//

import Foundation

/// This class is used to avoid creating multiple instances of scenes.
/// For example, a scene could be reused for both `UsersGridView` and `ScrollSelectorView`, if the user is the same.
class PlanetViewModelStore: ObservableObject {
    private(set) var models: [String: PlanetViewModel] = [:]

    func model(for user: User) -> PlanetViewModel {
        let key = "\(user.planet.textureName.rawValue)_\(user.planet.gradientName.rawValue)"
        
        if let existing = models[key] {
            return existing
        } else {
            let newModel = PlanetViewModel(user: user)
            models[key] = newModel

            return newModel
        }
    }
}
