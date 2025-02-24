//
//  SignInView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    @EnvironmentObject var session: SessionStore
    @FocusState private var isLabelFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .center) {
                    LogoView()
                    
                    Spacer()
                        .frame(maxHeight: 100)
                    
                    TextField(
                        "",
                        text: $viewModel.userConnectionPassword,
                        prompt: Text("Insira sua palavra-chave aqui!")
                            .foregroundStyle(Color(red: 0.8, green: 0.72, blue: 0.88))
                    )
                    .focused($isLabelFocused)
                    .frame(width: 320, height: 60)
                    .foregroundStyle(Color(red: 0.8, green: 0.72, blue: 0.88))
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .fontWidth(.expanded)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.textfield.opacity(0.1))
                            .stroke(
                                LinearGradient(
                                    colors: [.btf1, .btf2],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    }
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                        .frame(maxHeight: 20)
                    
                    Button {
                        isLabelFocused = false
                        viewModel.fetchUser()
                    } label: {
                        Group {
                            if viewModel.isFetchingUser {
                                HStack {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                    
                                    Text("Entrando...")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 14))
                                        .fontWeight(.medium)
                                        .fontWidth(.expanded)
                                }
                            } else {
                                Text("Entrar")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .fontWidth(.expanded)
                            }
                        }
                        .frame(width: 180, height: 50)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 128)
                            .fill(
                                LinearGradient(
                                    colors: [.btf1, .btf2],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                    .disabled(
                        viewModel.isFetchingUser || viewModel.foundUser != nil
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .blur(radius: viewModel.foundUser != nil ? 5 : 0)
                
                .alert(
                    "Error!",
                    isPresented: Binding(
                        get: { viewModel.errorMessage != nil },
                        set: { if !$0 { viewModel.errorMessage = nil }}
                    ),
                    presenting: viewModel.errorMessage
                ) { errMsg in
                    Button("OK") { viewModel.errorMessage = nil }
                } message: { errMsg in
                    Text(errMsg)
                }
                
                if let user = viewModel.foundUser {
                    UserConfirmationView(
                        user: user,
                        onUserConfirmed: {
                            viewModel.confirmSignIn(with: session)
                        },
                        onCancelled: {
                            viewModel.foundUser = nil
                        })
                    .transition(.scale.combined(with: .blurReplace))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image("bg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}

#Preview {
    SignInView()
}
