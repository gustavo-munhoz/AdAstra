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
            VStack{
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
                        ChipTextView(text: "\(user.age) years old")
                        ChipTextView(text: user.role.localized)
                        ChipTextView(text: user.shift.localized)
                    }
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                    .frame(maxHeight: 18)
                
                VStack(spacing: 8){
                    HStack(spacing: 4){
                        Text("💛️")
                            .font(.system(size: 12))
                        
                        Text("Interesses")
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
                        Text("⭐")
                            .font(.system(size: 12))
                        
                        Text("Curiosidade")
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
                        Text("📚")
                            .font(.system(size: 12))
                        
                        Text("Formação")
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
    }
}

#Preview {
    UserCardConnectedView(user: .mock)
}
