//
//  SignInView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import SwiftUI
import Pow

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
                        prompt: Text("Type your keyword here!")
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
                    .onSubmit {
                        isLabelFocused = false
                        viewModel.fetchUser()
                    }
                    .submitLabel(.search)
                    
                    Spacer()
                        .frame(maxHeight: 20)
                    
                    GradientButton(
                        title: NSLocalizedString("Sign in", comment: ""),
                        loadingTitle: NSLocalizedString("Signing in...", comment: ""),
                        isLoading: viewModel.isFetchingUser,
                        action: {
                            isLabelFocused = false
                            viewModel.fetchUser()
                        },
                        disabled: viewModel.userConnectionPassword.isEmpty || viewModel.isFetchingUser || viewModel.foundUser != nil
                    )
                    .onChange(of: viewModel.errorMessage) { _, newError in
                        guard newError != nil else { return }
                        
                        let generator = UINotificationFeedbackGenerator()
                        generator.prepare()
                        generator.notificationOccurred(.error)
                    }
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
                    .transition(.movingParts.blur.combined(with: .scale))
                    .zIndex(5)
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
