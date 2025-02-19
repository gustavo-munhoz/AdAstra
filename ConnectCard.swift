//
//  ConnectCard.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 19/02/25.
//

import SwiftUI

struct ConnectCard: View {
    @StateObject private var viewModel = UsersGridViewModel(mock: true)
    
    @State var start: UnitPoint = .topLeading
    @State var end: UnitPoint = .bottomTrailing
    
    @Binding var userConnected: Bool
    
    var body: some View {
        ZStack {
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
                }
                
                Button{
                    userConnected.toggle()
                }label: {
                    Text("Conecta pai")
                }
                
                Spacer()
            }
            .frame(width: 300, height: 450)
        }
        .frame(width: 350, height: 500)
        .padding(20)
        .cornerRadius(20)
    }
}
