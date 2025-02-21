//
//  TDPlanetView.swift
//  AdAstra
//
//  Created by Gustavo Binder on 16/02/25.
//

import SwiftUI
import SceneKit


struct TDPlanetView: View, Identifiable {
    var id: UUID = UUID()
    
    private var planetScene: SCNScene!
    private var planetNode: SCNNode!
    private var myView: ScenePlanetView
    
    init(_ user: User) {
        self.myView = ScenePlanetView(user.planet.textureName, user.planet.gradientName)
        guard let scene = self.myView.getScene() else {
            fatalError("Unable to get scene info")
        }
        
        self.planetScene = scene
        guard let node = self.planetScene.rootNode.childNode(withName: "planet", recursively: false) else {
            fatalError("Unable to get planet node")
        }
        
        self.planetNode = node
        self.planetNode.removeAllActions()
        
        let rotateAction = SCNAction.repeatForever(
            SCNAction
                .rotateBy(
                    x: 0,
                    y: CGFloat.pi * 2,
                    z: 0,
                    duration: Double.random(in: 7...12)
                )
        )
        
        self.planetNode.runAction(rotateAction)
    }
    
    var body: some View {
        myView
    }
}


#Preview {
    TDPlanetView(User.mock)
}
