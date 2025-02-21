//
//  ImageCache.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 21/02/25.
//

import UIKit

class ImageCache {
    static var cache: [String: UIImage] = [:]
    
    static func key(for texture: TextureName, gradient: GradientName) -> String {
        return "\(texture.rawValue)_\(gradient.rawValue)"
    }
    
    static func image(for texture: TextureName, gradient: GradientName) -> UIImage? {
        let key = self.key(for: texture, gradient: gradient)
        return cache[key]
    }
    
    static func store(image: UIImage, for texture: TextureName, gradient: GradientName) {
        let key = self.key(for: texture, gradient: gradient)
        cache[key] = image
    }
}
