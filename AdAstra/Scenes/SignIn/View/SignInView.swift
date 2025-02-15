//
//  SignInView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 13/02/25.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .center) {
                    Text("Ad Astra")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .fontWidth(.expanded)
                    
                    Spacer()
                        .frame(maxHeight: 350)
                    
                    TextField("Enter your access code...", text: $viewModel.userConnectionPassword)
                        .frame(width: 300, height: 50)
                        .foregroundStyle(.black)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.white)
                                .stroke(.indigo, lineWidth: 2)
                        }
                    
                    Button(action: viewModel.signIn) {
                        Group {
                            if viewModel.isFetchingUser {
                                HStack {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                    
                                    Text("Signing in...")
                                }
                            } else {
                                Text("Sign In")
                            }
                        }
                        .frame(width: 300, height: 50)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .stroke(.indigo, lineWidth: 2)
                    }
                    .disabled(
                        viewModel.isFetchingUser || viewModel.foundUser != nil
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray)
                .blur(radius: viewModel.foundUser != nil ? 3 : 0)
                
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
                    ZStack {
                        VStack(spacing: 16) {
                            Text("This you?")
                                .font(.title2)
                                .bold()
                            
                            Image(uiImage: user.profilePicture)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                            
                            Text("\(user.name)")
                            
                            HStack {
                                NavigationLink("Confirm") {
                                    UsersGridView()
                                }
                                .bold()
                                .padding()
                                .onTapGesture {
                                    viewModel.foundUser = nil
                                }
                                
                                Button("Cancel") {
                                    viewModel.foundUser = nil
                                }
                                .padding()
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.4))
                }
            }
        }
    }
}

#Preview {
    SignInView()
}
