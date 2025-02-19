//
//  TDPlanetView.swift
//  AdAstra
//
//  Created by Gustavo Binder on 16/02/25.
//

import SwiftUI
import SceneKit


struct TDPlanetView : View, Identifiable {
    var id: UUID = UUID()
    
    private var planetScene : SCNScene!
    private var planetNode : SCNNode!
    private var myView : ScenePlanetView
    
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var angle : Float = 0
    
    init() {
        self.myView = ScenePlanetView(angle: SCNQuaternion())
        guard let scene = self.myView.getScene() else {
            fatalError("unabled to get scene info")
        }
        
        self.planetScene = scene
        self.planetNode = self.planetScene.rootNode.childNode(withName: "planet", recursively: false)
    }
    
    var body : some View {
        myView
            .onReceive(timer) { _ in
                angle += 0.01
                self.planetNode.rotation = SCNQuaternion(x: 0, y: angle/8, z: 0, w: angle/8)
            }
    }
}

#Preview {
    TDPlanetView()
}
