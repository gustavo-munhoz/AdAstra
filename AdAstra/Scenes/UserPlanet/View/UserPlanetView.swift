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
    
    @State private var value: Int = 1
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("bg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                VStack(spacing: 0){
                    Spacer()
                    withAnimation {
                        UserCardView(data: "\(value)")
                            .frame(height: 300)
                            .offset(y: 50)
                    }
                    ScrollSelectorView(value: $value)
                        .padding(.top, -50)
                }
                .padding(.top, 150)
            }
            .sensoryFeedback(.impact, trigger: value)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .onAppear{
                scene.rootNode.addChildNode(SCNNode(geometry: SCNSphere(radius: 50)))
                scene.background.contents = UIColor.black
            }
        }
    }
}

#Preview {
    UserPlanetView()
}
