//
//  UsersGridView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import SwiftUI

struct UsersGridView: View {
    
    @StateObject private var viewModel = UsersGridViewModel()
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Group {
                if viewModel.isFetchingUsers {
                    ProgressView()
                    
                } else {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: { UserPlanetView() }) {
                                VStack {
                                    Circle()
                                    
                                    Text(user.name)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
    }
}

#Preview {
    UsersGridView()
}
