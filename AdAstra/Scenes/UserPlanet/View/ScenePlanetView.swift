//
//  ScenePlanetView.swift
//  AdAstra
//
//  Created by Gustavo Binder on 17/02/25.
//

import SceneKit
import SwiftUI

struct ScenePlanetView: UIViewRepresentable {
    typealias UIViewType = SCNView
    typealias Context = UIViewRepresentableContext<ScenePlanetView>
    
    var scene : SCNScene!

    init() {
        scene = makeScene()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.scene = scene
    }
    func makeUIView(context: Context) -> UIViewType {
        let view = SCNView()
        view.backgroundColor = UIColor.clear
        view.allowsCameraControl = false
        view.autoenablesDefaultLighting = false
        view.scene = scene
        return view
    }
    
    func getScene() -> SCNScene! {
        return scene
    }
    
    func makeScene() -> SCNScene {
        let light = SCNLight()
        let lightNode = SCNNode()
        
        light.type = .directional
        lightNode.light = light
        lightNode.rotation = SCNQuaternion(x: -0.5, y: 1, z: 0, w: 1)
        
        let newScene = SCNScene()
        let planetNode = SCNNode(geometry: SCNSphere(radius: 2))
        planetNode.name = "planet"
        planetNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "planet")
        
        newScene.rootNode.addChildNode(planetNode)
        newScene.rootNode.addChildNode(lightNode)
        newScene.background.contents = UIColor(.clear)
        
        return newScene
    }
}

#Preview{
    UserPlanetView()
}
