//
//  ConnectCard.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 19/02/25.
//

import SwiftUI

struct ConnectCard: View {
    //Super machista opressor
    //Parabéns, você achou o comentário perdido. Tome água
    @StateObject private var viewModel = UsersGridViewModel(mock: true)
    
    @State var start: UnitPoint = .topLeading
    @State var end: UnitPoint = .bottomTrailing
    
    @State var placeholderText = ""
    
    @Binding var userConnected: Bool
    
    @FocusState private var isLabelFocused: Bool
    
    var body: some View {
        ZStack {
            VStack{
                
                Spacer()
                    .frame(maxHeight: 12)
                
                Image(uiImage: viewModel.users[0].profilePicture)
                    .resizable()
                    .frame(width: 132, height: 132)
                    .clipShape(Circle())
                    .background {
                        Circle()
                            .stroke(Color(.sp), lineWidth: 4)
                    }
                
                Text("\(viewModel.users[0].name)")
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .fontWidth(.expanded)
                
                HStack{
                    ChipTextView(text: viewModel.users[0].pronouns)
                    ChipTextView(text: viewModel.users[0].age.formatted())
                }
                
                Spacer()
                    .frame(maxHeight: 64)
                
                TextField("", text: $placeholderText, prompt: Text("Insira a palavra-chave aqui").foregroundStyle(Color(red: 0.8, green: 0.72, blue: 0.88)))
                    .focused($isLabelFocused)
                    .frame(width: 300, height: 50)
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
                    //viewModel.makeconnection()
                    userConnected.toggle()
                } label: {
                    Group {
                        if false { //isConnectingUser
                            HStack {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                
                                Text("Conectando...")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                                    .fontWeight(.medium)
                                    .fontWidth(.expanded)
                            }
                        } else {
                            Text("Conectar-se")
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
                    placeholderText == ""
                )
                
                Spacer()
            }
            .frame(width: 300, height: 450)
        }
        .frame(width: 350, height: 500)
        .padding(20)
        .cornerRadius(20)
    }
}

#Preview {
    UserCardView()
}
