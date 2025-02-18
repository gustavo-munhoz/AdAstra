//
//  SignInView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bg")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
                VStack(alignment: .center) {
                    LogoView()
                    
                    Spacer()
                        .frame(maxHeight: 100)
                    
                    TextField("", text: $viewModel.userConnectionPassword, prompt: Text("Insira sua palavra-chave aqui!").foregroundStyle(Color(red: 0.8, green: 0.72, blue: 0.88)))
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
                                .stroke(AngularGradient(colors: [.btf1, .btf2], center: UnitPoint(x: 0.5, y: 0.5), angle: Angle(degrees: 45)), lineWidth: 1)
                        }
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                        .frame(maxHeight: 20)
                    
                    Button(action: viewModel.signIn) {
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
                            .fill(LinearGradient(colors: [.btf1, .btf2], startPoint: .topLeading, endPoint: .bottomTrailing))
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
                    UserConfirmationView(user: user, viewModel: viewModel)
                        .transition(.scale.combined(with: .blurReplace))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    SignInView()
}
