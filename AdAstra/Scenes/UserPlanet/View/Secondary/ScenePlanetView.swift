//
//  ScenePlanetView.swift
//  AdAstra
//
//  Created by Gustavo Binder on 17/02/25.
//

import SceneKit
import SwiftUI

class SceneHolder {
    let scene: SCNScene
    
    init(texture: TextureName, gradient: GradientName) {
        if let cached = SceneCache.scene(for: texture, gradient: gradient) {
            self.scene = cached
            return
        }
        
        let newScene = ScenePlanetView.makeScene(texture, gradient)
        SceneCache.store(scene: newScene, for: texture, gradient: gradient)
        self.scene = newScene
    }
}

struct ScenePlanetView: UIViewRepresentable {
    typealias UIViewType = SCNView
    typealias Context = UIViewRepresentableContext<ScenePlanetView>
    
    private let holder: SceneHolder
    
    init(sceneHolder: SceneHolder) {
        self.holder = sceneHolder
    }
    
    func makeUIView(context: Context) -> UIViewType {
        let view = SCNView()
        view.backgroundColor = UIColor.clear
        view.allowsCameraControl = false
        view.autoenablesDefaultLighting = false
        view.scene = holder.scene
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.scene = holder.scene
    }
    
    func getScene() -> SCNScene! {
        return holder.scene
    }
    
    static func makeScene(_ texture: TextureName, _ gradient: GradientName) -> SCNScene {
        let scene = SCNScene()
        scene.background.contents = UIColor.clear
        
        let planetNode = createPlanetNode(texture: texture, gradient: gradient)
        let lightNode = createLightNode()
        let cameraNode = createCameraNode()
        
        scene.rootNode.addChildNode(planetNode)
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cameraNode)
        
        return scene
    }
}

// MARK: - Helper Methods
extension ScenePlanetView {
    private static func getTintedImage(for texture: TextureName, gradient: GradientName) -> UIImage {
        if let cachedImage = ImageCache.image(for: texture, gradient: gradient) {
            return cachedImage
        }
        
        guard let image = UIImage(named: texture.rawValue),
              let tinted = image.tintedWithGradient(gradientColors: gradient.gradientColors)
        else {
            return UIImage()
        }
        
        ImageCache.store(image: tinted, for: texture, gradient: gradient)
        
        return tinted
    }
    
    private static func createPlanetNode(texture: TextureName, gradient: GradientName) -> SCNNode {
        let sphere = SCNSphere(radius: 2)
        sphere.segmentCount = 48
        
        let planetNode = SCNNode(geometry: sphere)
        planetNode.name = "planet"
        planetNode.scale = SCNVector3(1, 1, 1)
        
        let tintedImage = getTintedImage(for: texture, gradient: gradient)
        
        sphere.firstMaterial?.diffuse.contents = tintedImage
        
        return planetNode
    }
    
    private static func createLightNode() -> SCNNode {
        let light = SCNLight()
        light.type = .directional
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.rotation = SCNQuaternion(x: -0.5, y: 1, z: 0, w: 1)
        
        return lightNode
    }
    
    private static func createCameraNode() -> SCNNode {
        let camera = SCNCamera()
        camera.fieldOfView = 60
        
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5.5)
        
        return cameraNode
    }
}
