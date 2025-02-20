//
//  UserPlanetContainerView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 19/02/25.
//

import SwiftUI

struct UserPlanetContainerView: View {
    let users: [User]
    let title: String
    @State private var selectedIndex: Int = 0
    
    init(users: [User], title: String, initialIndex: Int = 0) {
        self.users = users
        self.title = title
        self._selectedIndex = State(initialValue: initialIndex)
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationStack{
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
        }
        .navigationTitle(title)
        .sensoryFeedback(.impact, trigger: selectedIndex)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
