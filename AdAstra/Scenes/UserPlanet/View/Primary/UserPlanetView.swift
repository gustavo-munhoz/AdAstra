//
//  UserPlanetView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import SwiftUI
import SceneKit

struct UserPlanetView: View {
    
    @StateObject private var viewModel: UserPlanetViewModel
    
    @EnvironmentObject var session: SessionStore
    
    @State var rotationAnimation = 0.0
    @State var scaleAnimation = 1.0
    
    @State var start: UnitPoint = .topLeading
    @State var end: UnitPoint = .bottomTrailing
    
    @State var isCardFlipped: Bool = false
    
    private var isUserConnected: Bool {
        guard let currentUser = session.currentUser else {
            return false
        }
        
        return currentUser.isConnected(to: viewModel.user)
    }
    
    init(user: User) {
        _viewModel = StateObject(
            wrappedValue: UserPlanetViewModel(user: user)
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
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
                    if isUserConnected {
                        VStack{
                            UserCardConnectedView(user: viewModel.user)
                                .offset(y: 20)
                            Spacer()
                        }
                        
                    } else {
                        UserCardNotConnectedView(
                            user: viewModel.user,
                            keywordInput: $viewModel.keywordInput,
                            onConnectPressed: connectToUser
                        )
                        .frame(width: 300, height: 450)
                    }
                }
                .onChange(of: viewModel.errorMessage) { _, newError in
                    guard newError != nil else { return }
                    
                    let generator = UINotificationFeedbackGenerator()
                    generator.prepare()
                    generator.notificationOccurred(.error)
                }
                .clipped()
            }
            .frame(width: 350, height: 500)
            .rotation3DEffect(
                Angle(degrees: isCardFlipped ? 180 : 0),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .scaleEffect(scaleAnimation)
            .onChange(of: isUserConnected) {
                rotate()
                scale()
            }
            .padding(20)
            .cornerRadius(20)
            .onAppear {
                withAnimation {
                    isCardFlipped = isUserConnected
                }
            }
            .alert(
                "Error!",
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { if !$0 { viewModel.errorMessage = nil }}
                ),
                presenting: viewModel.errorMessage
            ) { errMsg in
                Button("OK") { viewModel.errorMessage = nil }
            } message: { errMsg in
                Text(errMsg)
            }
            
            Spacer()
        }
        .padding(.top, 150)
    }
    
    private func connectToUser() {
        do {
            try viewModel.connectToUser(session: session)
            
        } catch {
            viewModel.errorMessage = error.localizedDescription
            
            print(error.localizedDescription)
        }
    }
    
    func rotate(){
        withAnimation(.linear(duration: 0.5)){
            isCardFlipped.toggle()
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
    UserPlanetView(user: .mock)
        .environmentObject(
            SessionStore()
        )
}
