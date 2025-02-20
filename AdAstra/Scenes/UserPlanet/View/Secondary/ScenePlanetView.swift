//
//  ScenePlanetView.swift
//  AdAstra
//
//  Created by Gustavo Binder on 17/02/25.
//

import SceneKit
import SwiftUI

extension UIImage {
    
    func tint(with color: UIColor) -> UIImage
    {
       UIGraphicsBeginImageContext(self.size)
       guard let context = UIGraphicsGetCurrentContext() else { return self }
        context.setBlendMode(.multiply)

       let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
       context.clip(to: rect, mask: self.cgImage!)
        color.setFill()
       context.fill(rect)

       // create UIImage
       guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
       UIGraphicsEndImageContext()

       return newImage
    }
}

struct ScenePlanetView: UIViewRepresentable {
    typealias UIViewType = SCNView
    typealias Context = UIViewRepresentableContext<ScenePlanetView>
    
    var scene : SCNScene!

    init(_ texture: TextureName, _ gradient: GradientName) {
        scene = makeScene(texture, gradient)
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
    
    func makeScene(_ texture: TextureName, _ gradient: GradientName) -> SCNScene {
        let light = SCNLight()
        let lightNode = SCNNode()
        
        light.type = .directional
        lightNode.light = light
        lightNode.rotation = SCNQuaternion(x: -0.5, y: 1, z: 0, w: 1)
        
        let newScene = SCNScene()
        let planetNode = SCNNode(geometry: SCNSphere(radius: 2))
        planetNode.name = "planet"
        
        let image = UIImage(named: texture.rawValue)
        let newImage = image?.tint(with: UIColor(named: gradient.rawValue)!)

        planetNode.geometry?.firstMaterial?.diffuse.contents = newImage
        
        newScene.rootNode.addChildNode(planetNode)
        newScene.rootNode.addChildNode(lightNode)
        newScene.background.contents = UIColor(.clear)
        
        return newScene
    }
}

#Preview{
    TDPlanetView(User.mock)
}
