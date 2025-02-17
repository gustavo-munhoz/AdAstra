//
//  UserPlanetView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import SwiftUI
import SceneKit

struct UserPlanetView: View {
    var scene = SCNScene()
    
    var cameraNode: SCNNode? {
        scene.rootNode.childNode(withName: "camera", recursively: false)
    }
    
    @State private var value: Int = 0
    
    var body: some View {
        ZStack{
                HStack(spacing: 0){
                    Spacer()
                    ScrollSelectorView(value: $value)
                        .frame(height: 450)
                    UserCardView(data: "\(value)")
                    Spacer()
                }
            .frame(maxHeight: .infinity)

        }
        .sensoryFeedback(.impact, trigger: value)
        .frame(maxHeight: .infinity)
        .background(.black)
        .onAppear{
            scene.rootNode.addChildNode(SCNNode(geometry: SCNSphere(radius: 50)))
            scene.background.contents = UIColor.black
        }
    }
}

#Preview {
    UserPlanetView()
}
