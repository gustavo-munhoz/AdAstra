//
//  UsersGridView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 14/02/25.
//

import SwiftUI

struct UsersGridView: View {
        
    let users: [User]
    let title: String
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var angle = 0.0
    @Namespace private var userDetailsNamespace
        
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Array(users.enumerated()), id: \.element.id) { index, user in
                NavigationLink(
                    destination: {
                        if #available(iOS 18.0, *) {
                            UserPlanetContainerView(
                                users: users,
                                title: title,
                                initialIndex: index
                            )
                            .navigationTransition(.zoom(sourceID: users[index].id, in: userDetailsNamespace))
                        } else {
                            UserPlanetContainerView(
                                users: users,
                                title: title,
                                initialIndex: index
                            )
                        }
                    }) {
                        VStack {
                            ZStack(alignment: .center){
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .border(.red)
                                    .foregroundStyle(Color(user.planet.gradientName.rawValue))
                                    .blur(radius: 15)
                                
                                if #available(iOS 18.0, *) {
                                    TDPlanetView(user)
                                        .frame(width: 80, height: 80)
                                        .matchedTransitionSource(id: users[index].id, in: userDetailsNamespace)
                                } else {
                                    TDPlanetView(user)
                                        .frame(width: 80, height: 80)
                                }
                                
                                Image(uiImage: user.profilePicture)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                    .background {
                                        Circle()
                                            .stroke(LinearGradient(colors: [.btf1, .btf2], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4)
                                            .rotationEffect(Angle(degrees: angle))
                                            .onAppear{
                                                withAnimation(.linear(duration: 10).repeatForever(autoreverses: true)){
                                                    angle = 360
                                                }
                                                
                                            }
                                    }
                                    .offset(x: 20, y: 20)

                            }
                            
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
