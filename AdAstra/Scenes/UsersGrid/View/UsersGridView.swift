//
//  UsersGridView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import SwiftUI

struct UsersGridView: View {
    
    @StateObject private var viewModel = UsersGridViewModel(mock: true)
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .center){
            Group {
                if viewModel.isFetchingUsers {
                    ProgressView()
                    
                } else {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(viewModel.users) { user in
                            ViewThatFits(in: .horizontal){
                                NavigationLink(destination: { UserPlanetView() }) {
                                    VStack {
                                        Circle()
                                            .frame(width: 80)
                                        Text(user.name)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.5)
                                            .frame(width: 80)
                                    }
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
