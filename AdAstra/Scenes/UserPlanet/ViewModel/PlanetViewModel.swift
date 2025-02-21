//
//  PlanetViewModel.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 21/02/25.
//

import Foundation
import SceneKit

class PlanetViewModel: ObservableObject {
    let sceneHolder: SceneHolder

    init(user: User) {
        self.sceneHolder = SceneHolder(
            texture: user.planet.textureName,
            gradient: user.planet.gradientName
        )
        
        guard let node = sceneHolder.scene.rootNode.childNode(withName: "planet", recursively: false) else {
            fatalError("Unable to get planet node")
        }
        
        node.removeAllActions()
        let rotateAction = SCNAction.repeatForever(
            SCNAction.rotateBy(
                x: 0,
                y: CGFloat.pi * 2,
                z: 0,
                duration: Double.random(in: 7...12)
            )
        )
        node.runAction(rotateAction)
    }
}
