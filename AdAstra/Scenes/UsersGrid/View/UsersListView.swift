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
            if viewModel.isFetchingUsers {
                LoadingView(loadingText: "Loading users...")
                    .transition(.opacity)
            } else {
                VStack {
                    ScrollView {
                        LogoView()
                            .scaleEffect(0.5)
                            .padding(.vertical)
                        
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
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: viewModel.isFetchingUsers)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            if !viewModel.isFetchingUsers {
                Button("Sign out") {
                    viewModel.signOut(with: session)
                }
                .accentColor(.white)
                .fontWeight(.medium)
                .fontWidth(.expanded)
                .foregroundStyle(.white)
            }
            
        }
        .navigationBarBackButtonHidden()
        .background {
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
        }
    }
}
