//
//  UserCardView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 13/02/25.
//

import SwiftUI

struct UserCardView: View {
    let data: String
    @StateObject private var viewModel = UsersGridViewModel(mock: true)
    
    var body: some View {
        VStack{
            HStack{
                Text(viewModel.users[0].name)
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .fontWidth(.expanded)
                Spacer()
                
                HStack(spacing: 4){
                    Text("🤝")
                        .font(.system(size: 16))
                    
                    /// If connectedUser.conections have this.user blablabla
                    Text("Conexão feita")
                        .foregroundStyle(.white)
                        .font(.system(size: 11))
                        .fontWeight(.medium)
                        .fontWidth(.expanded)
                    ///----------------------------------------
                }
                .frame(width: 131, height: 31)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.sp)
                }
            }
            .multilineTextAlignment(.leading)
            
            Spacer()
                .frame(maxHeight: 12)
            
            //Tags
            ScrollView(.horizontal){
                HStack(spacing: 8){
                    ChipTextView(text: viewModel.users[0].pronouns)
                    ChipTextView(text: "20 anos") //viewModel.users[0].age
                    ChipTextView(text: "mentoria jr.") //viewModel.users[0].role
                    ChipTextView(text: viewModel.users[0].shift)
                }
            }
            .scrollIndicators(.hidden)
            
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
                
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.dp)
                        .frame(height: 85, alignment: .center)
                        .frame(maxWidth: .infinity)
                    
                    Text("🔒 Clique aqui para liberar a curiosidade.")
                        .foregroundStyle(.logo)
                        .font(.system(size: 10))
                        .fontWeight(.semibold)
                        .fontWidth(.expanded)
                }
                
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
                    Text("\(viewModel.users[0].course) | \(viewModel.users[0].institution)")
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
                    Text(interests())
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
        }
        .frame(width: 300, height: 450)
        .padding(20)
        .cornerRadius(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.p2.opacity(0.8))
                .stroke(LinearGradient(colors: [.btf1, .btf2], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
        )
    }
    
    func interests() -> String {
        var interests = ""
        for interest in viewModel.users[0].interests{
            interests+="\(interest), "
        }
        
        interests.removeLast(2)
        
        return interests
    }
}

#Preview {
    UserPlanetView()
}
