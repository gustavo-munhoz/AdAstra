//
//  UserConfirmationView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 18/02/25.
//

import SwiftUI

struct UserConfirmationView: View {
    var user: User
    
    var onUserConfirmed: () -> Void
    var onCancelled: () -> Void
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack{
            Text("Is this you?")
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
            
            Text(user.name)
                .foregroundStyle(.white)
                .font(.system(size: 24))
                .fontWeight(.medium)
                .fontWidth(.expanded)
            
            Spacer()
                .frame(maxHeight: 64)
            
            VStack(spacing: 20){
                NavigationLink {
                    UsersListView()
                } label: {
                    Text("That's me!")
                        .frame(width: 270, height: 60)
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .fontWidth(.expanded)
                        .background {
                            GradientRectangle()
                        }
                        .simultaneousGesture(TapGesture().onEnded({
                            withAnimation {
                                onUserConfirmed()
                            }
                        }))
                }
                .buttonStyle(PushDownButtonStyle())
                .sensoryFeedback(.success, trigger: session.currentUser)
                
                Button {
                    withAnimation {
                        onCancelled()
                    }
                } label: {
                    Text("Cancel")
                        .frame(width: 270, height: 60)
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .fontWidth(.expanded)
                        .background {
                            GradientRectangleStroke()
                        }
                }
                .buttonStyle(PushDownButtonStyle())
            }
        }
        .frame(width: 350, height: 550)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.dp.opacity(0.85))
                .stroke(
                    LinearGradient(
                        colors: [.btf1, .btf2],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
                .shadow(radius: 20.0)
        }
    }
}

#Preview {
    SignInView()
}
