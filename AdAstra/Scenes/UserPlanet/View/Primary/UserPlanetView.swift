//
//  UserPlanetView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import SwiftUI
import SceneKit

struct UserPlanetView: View {
    
    //    @State private var value: Int = 1
    
    @StateObject private var viewModel: UserPlanetViewModel
    
    @EnvironmentObject var session: SessionStore
    
    @State var rotationAnimation = 0.0
    @State var scaleAnimation = 1.0
    
    @State var start: UnitPoint = .topLeading
    @State var end: UnitPoint = .bottomTrailing
    
    @State var isFlipped: Bool = false
    
    private let numberOfUsers: Int
    
    init(user: User, index: Int, numberOfUsers: Int) {
        _viewModel = StateObject(
            wrappedValue: UserPlanetViewModel(user: user, userIndex: index)
        )
        
        self.numberOfUsers = numberOfUsers
    }
    
    var userCard: some View {
        withAnimation {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.p2.opacity(0.8))
                    .stroke(
                        LinearGradient(
                            colors: [.btf1, .btf2],
                            startPoint: start,
                            endPoint: end
                        ),
                        lineWidth: 1
                    )
                    .shadow(radius: 10)
                
                Group {
                    if isFlipped {
                        UserCardConnectedView(user: viewModel.user)
                            .frame(height: 300)
                            .offset(y: 50)
                        
                    } else {
                        UserCardNotConnectedView(
                            user: viewModel.user,
                            keywordInput: $viewModel.keywordInput,
                            onConnectPressed: connectToUser
                        )
                        .frame(width: 300, height: 450)
                    }
                }
            }
            .frame(width: 350, height: 500)
            .rotation3DEffect(
                Angle(degrees: isFlipped ? 180 : 0),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .scaleEffect(scaleAnimation)
            .onChange(of: session.currentUser?.isConnected(to: viewModel.user)) {
                rotate()
                scale()
            }
            .padding(20)
            .cornerRadius(20)
        }
    }
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            VStack(spacing: 0) {
                Spacer()
                
                userCard
                
                ScrollSelectorView(
                    value: $viewModel.userIndex,
                    numberOfUsers: numberOfUsers
                )
                .padding(.top, -50)
            }
            .padding(.top, 150)
        }
        .sensoryFeedback(.impact, trigger: viewModel.userIndex)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
    
    private func connectToUser() {
        do {
            try viewModel.connectToUser(viewModel.user, session: session)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func rotate(){
        withAnimation(.linear(duration: 0.5)){
            isFlipped.toggle()
        }
    }
    
    func scale(){
        withAnimation(.easeInOut(duration: 0.2)){
            scaleAnimation = 0.5
        }
        withAnimation(.easeInOut(duration: 0.2).delay(0.2)){
            scaleAnimation = 1.0
        }
    }
}

#Preview {
    UserPlanetView(user: .mock, index: 0, numberOfUsers: 10)
        .environmentObject(
            SessionStore()
        )
}
