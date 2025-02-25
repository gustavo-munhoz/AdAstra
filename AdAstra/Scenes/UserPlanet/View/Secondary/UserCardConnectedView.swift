//
//  UserCardConnectedView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 13/02/25.
//

import SwiftUI

struct UserCardConnectedView: View {
    @State var user: User
    
    @State var rotationAnimation = 0.0
    @State var scaleAnimation = 1.0
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 6) {
                HStack{
                    Text(user.name)
                        .foregroundStyle(.white)
                        .font(.system(size: 24))
                        .fontWeight(.semibold)
                        .fontWidth(.expanded)
                    Spacer()
                }
                .multilineTextAlignment(.leading)
                
                Spacer()
                    .frame(maxHeight: 12)
                
                ScrollView(.horizontal){
                    HStack(spacing: 8){
                        ChipTextView(text: user.pronouns)
                        ChipTextView(
                            text: String(localized: "\(user.getFormattedAge()) years old")
                        )
                        ChipTextView(text: user.role.localized)
                        ChipTextView(text: user.shift.localized)
                    }
                    .padding(2)
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                    .frame(maxHeight: 18)
                
                VStack(spacing: 8){
                    HStack(spacing: 4){
                        Text("💛️ Interests")
                            .foregroundStyle(.logo)
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .fontWidth(.expanded)
                        
                        Spacer()
                    }
                    
                    HStack{
                        Text(user.interests)
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.sp.opacity(0.1))
                    )
                }
                
                Spacer()
                    .frame(maxHeight: 18)
                
                VStack(spacing: 8){
                    HStack(spacing: 4){
                        Text("⭐ Curiosity")
                            .foregroundStyle(.logo)
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .fontWidth(.expanded)
                        
                        Spacer()
                    }
                    
                    HStack{
                        Text(user.secretFact)
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.sp.opacity(0.1))
                    )
                }
                
                Spacer()
                    .frame(maxHeight: 18)
                
                VStack(spacing: 8){
                    HStack(spacing: 4){
                        Text("📚 Education")
                            .foregroundStyle(.logo)
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .fontWidth(.expanded)
                        
                        Spacer()
                    }
                    
                    HStack{
                        Text(user.course)
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.sp.opacity(0.1))
                    )
                }
            }
            .frame(width: 300)
            .scaleEffect(x: -1.0)
            .clipped()
        }
        .scrollIndicators(.hidden)
        .padding(.bottom, 32)
    }
}

#Preview {
    UserCardConnectedView(user: .mock)
}
