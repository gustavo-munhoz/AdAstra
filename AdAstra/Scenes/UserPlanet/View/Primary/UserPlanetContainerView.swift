//
//  UserPlanetContainerView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 19/02/25.
//

import SwiftUI

struct UserPlanetContainerView: View {
    let users: [User]
    @State private var selectedIndex: Int = 0
    
    init(users: [User], initialIndex: Int = 0) {
        self.users = users
        self._selectedIndex = State(initialValue: initialIndex)
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
                        numberOfUsers: users.count,
                        users: users
                    )
                    .padding(.top, -150)
                }
            }
        }
        .sensoryFeedback(.impact, trigger: selectedIndex)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
