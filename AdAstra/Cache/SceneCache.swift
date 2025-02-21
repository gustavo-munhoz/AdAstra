//
//  SceneCache.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 21/02/25.
//

import SceneKit

class SceneCache {
    static var cache: [String: SCNScene] = [:]
    
    static func scene(for texture: TextureName, gradient: GradientName) -> SCNScene? {
        let key = "\(texture.rawValue)_\(gradient.rawValue)"
        return cache[key]
    }
    
    static func store(scene: SCNScene, for texture: TextureName, gradient: GradientName) {
        let key = "\(texture.rawValue)_\(gradient.rawValue)"
        cache[key] = scene
    }
}
