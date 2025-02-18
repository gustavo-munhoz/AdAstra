//
//  UserConfirmationView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 18/02/25.
//

import SwiftUI

struct UserConfirmationView: View {
    var user: User
    var viewModel: SignInViewModel
    
    var body: some View {
        VStack{
            Text("É você?")
                .foregroundStyle(.white)
                .font(.system(size: 24))
                .fontWeight(.medium)
                .fontWidth(.expanded)
                .padding(.top, 40)
            
            Spacer()
                .frame(maxHeight: 64)
            
            Image(uiImage: user.profilePicture)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .background {
                    Circle()
                        .stroke(Color(.sp), lineWidth: 4)
                }
            
            Text("\(user.name)")
                .foregroundStyle(.white)
                .font(.system(size: 24))
                .fontWeight(.medium)
                .fontWidth(.expanded)
            
            Spacer()
                .frame(maxHeight: 64)
            
            VStack(spacing: 20){
                NavigationLink("Sou eu") {
                    UsersGridView()
                }
                .frame(width: 270, height: 60)
                .foregroundStyle(.white)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .fontWidth(.expanded)
                .background {
                    RoundedRectangle(cornerRadius: 128)
                        .fill(LinearGradient(colors: [.btf1, .btf2], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                .onTapGesture {
                    withAnimation{
                        viewModel.foundUser = nil
                    }
                }
                
                Button("Cancel") {
                    withAnimation{
                        viewModel.foundUser = nil
                    }
                }
                .frame(width: 270, height: 60)
                .foregroundStyle(.white)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .fontWidth(.expanded)
                .background {
                    RoundedRectangle(cornerRadius: 128)
                        .fill(.textfield.opacity(0.1))
                        .stroke(LinearGradient(colors: [.btf1, .btf2], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
                }
            }
        }
        .frame(width: 350, height: 550)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.dp.opacity(0.85))
                .stroke(LinearGradient(colors: [.btf1, .btf2], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
                .shadow(radius: 20.0)
        }
    }
}

#Preview {
    SignInView()
}
