//
//  UsersGridView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import SwiftUI

struct UsersGridView: View {
        
    let users: [User]
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        //        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Array(users.enumerated()), id: \.element.id) { index, user in
                NavigationLink(
                    destination: {
                        UserPlanetContainerView(
                            users: users,
                            initialIndex: index
                        )
                    }) {
                        VStack {
                            Circle()
                                .frame(width: 80, height: 80)
                            
                            Text(user.name)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .frame(width: 80)
                        }
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
    }
}

#Preview {
    //    UsersGridView(viewModel: UsersListViewModel(mock: false))
}
