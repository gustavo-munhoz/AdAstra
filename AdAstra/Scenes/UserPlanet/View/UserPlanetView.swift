//
//  UserPlanetView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import SwiftUI
import SceneKit

struct UserPlanetView: View {
    var user : User!
    var viewModel : UsersGridViewModel!
    
//    var cameraNode: SCNNode? {
//        scene.rootNode.childNode(withName: "camera", recursively: false)
//    }
    
    @State private var value: Int = 1
    
    init(user: User, viewModel: UsersGridViewModel) {
        self.user = user
        self.viewModel = viewModel
    }
    
    var body: some View {
<<<<<<< Updated upstream
        NavigationStack{
            ZStack{
                Image("bg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                VStack(spacing: 0){
                    Spacer()
                    withAnimation {
                        UserCardView()
                            .frame(height: 300)
                            .offset(y: 50)
                    }
                    ScrollSelectorView(value: $value)
                        .padding(.top, -50)
=======
        ZStack{
                VStack(spacing: 0){
                    Spacer()
                    withAnimation {
                        UserCardView(data: "\(value)")
                            .frame(height: 400)
                    }
                    ScrollSelectorView(value: $value)
                    Spacer()
>>>>>>> Stashed changes
                }
                .padding(.top, 150)
            }
            .sensoryFeedback(.impact, trigger: value)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
        }
        .onAppear() {
            for i in 0..<viewModel.users.count {
                if self.user.name == viewModel.users[i].name {
                    print("achei!")
                    print(value)
                    break
                }
                value += 1
                print(self.value)
                print("não é esse")
            }
        }
    }
}

#Preview {
    UserPlanetView(user: User(id: "Bruh", name: "pirulitu", course: "Brush", institution: "Brush", shift: "Brush", interests: [], pronouns: "Brush", connectionPassword: "Brush", connectionCount: 0, connectedUsers: [], secretFact: "Bruh", profilePicture: UIImage(systemName: "person.circle")!, planet: Planet(name: "Bruh")), viewModel: UsersGridViewModel(mock: true))
}
