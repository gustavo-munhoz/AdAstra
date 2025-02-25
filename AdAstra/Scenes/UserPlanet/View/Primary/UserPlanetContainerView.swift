//
//  UserPlanetContainerView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 19/02/25.
//

import SwiftUI
import Pow

struct UserPlanetContainerView: View {
    let users: [User]
    let title: String
    @State private var selectedIndex: Int = 0
    @Environment(\.dismiss) private var dismiss
    
    let planetStore: PlanetViewModelStore
    
    @State private var zoomedUser: User?
    
    init(users: [User], title: String, initialIndex: Int = 0, planetStore: PlanetViewModelStore) {
        self.users = users
        self.title = title
        self._selectedIndex = State(initialValue: initialIndex)
        self.planetStore = planetStore
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
            
            VStack {
                if users.isEmpty {
                    ProgressView()
                    
                } else {
                    UserPlanetView(user: users[selectedIndex])
                        .id(users[selectedIndex].id)
                    
                    ScrollSelectorView(
                        value: $selectedIndex,
                        users: users,
                        planetStore: planetStore,
                        onPlanetLongPress: presentZoomedUser(_:)
                    )
                    .padding(.top, -150)
                }
            }
            
            if let zoomedUser {
                ZoomedUserView(
                    user: zoomedUser,
                    onClosePressed: dismissZoomedUser
                )
                .transition(.movingParts.blur.combined(with: .scale))
                .zIndex(3)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .sensoryFeedback(.impact, trigger: selectedIndex)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .toolbar {
            
            // 2
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button {
                    // 3
                    dismiss()
                    
                } label: {
                    // 4
                    HStack {
                        
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.white)
                        Text("Back")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
    
    private func presentZoomedUser(_ user: User) {
        withAnimation { zoomedUser = user }
    }
    
    private func dismissZoomedUser() {
        withAnimation { zoomedUser = nil }
    }
}
