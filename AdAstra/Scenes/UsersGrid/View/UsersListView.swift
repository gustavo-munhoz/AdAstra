//
//  UsersListView.swift
//  AdAstra
//
//  Created by Gustavo Binder on 18/02/25.
//

import SwiftUI

struct UsersListView: View {
    
    @StateObject private var viewModel : UsersGridViewModel = UsersGridViewModel(mock: false)
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
//                        DisclosureView(viewModel: viewModel, title: "Manhã")
//                        DisclosureView(viewModel: viewModel, title: "Tarde")
//                        DisclosureView(viewModel: viewModel, title: "Mentoria")
                        DisclosureView(title: "Manhã")
                        DisclosureView(title: "Tarde")
                        DisclosureView(title: "Mentoria")
                            .padding(.bottom, 50)
                        Spacer()
                    }
                }
            }
            .environmentObject(viewModel)
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    UsersListView()
}
