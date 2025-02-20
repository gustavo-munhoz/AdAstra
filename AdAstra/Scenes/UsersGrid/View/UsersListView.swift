//
//  UsersListView.swift
//  AdAstra
//
//  Created by Gustavo Binder on 18/02/25.
//

import SwiftUI

struct UsersListView: View {
    
    @StateObject private var viewModel = UsersListViewModel()
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            VStack {
                ScrollView {
                    LogoView()
                        .scaleEffect(CGSize(width: 0.5, height: 0.5))
                        .padding(.vertical)
                    
                    if viewModel.isFetchingUsers {
                        Text("Loading...")
                            .accentColor(.white)
                            .fontWeight(.medium)
                            .fontWidth(.expanded)
                            .foregroundStyle(.white)
                        
                    } else {
                        DisclosureView(
                            title: "Manhã",
                            users: viewModel.morningStudents
                        )
                        
                        DisclosureView(
                            title: "Tarde",
                            users: viewModel.afternoonStudents
                        )
                        
                        DisclosureView(
                            title: "Mentoria",
                            users: viewModel.mentors
                        )
                        .padding(.bottom, 50)
                        
                        Spacer()
                    }
                }
            }
        }
        .toolbar {
            Button("Sign out") {
                viewModel.signOut(with: session)
            }
            .accentColor(.white)
            .fontWeight(.medium)
            .fontWidth(.expanded)
            .foregroundStyle(.white)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    UsersListView()
}
