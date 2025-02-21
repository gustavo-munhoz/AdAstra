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
    @Environment(\.dismiss) private var dismiss
    
    init(users: [User], title: String, initialIndex: Int = 0) {
        self.users = users
        self.title = title
        self._selectedIndex = State(initialValue: initialIndex)
        
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
                        numberOfUsers: users.count,
                        users: users
                    )
                    .padding(.top, -150)
                }
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
                        Text("Voltar")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}
