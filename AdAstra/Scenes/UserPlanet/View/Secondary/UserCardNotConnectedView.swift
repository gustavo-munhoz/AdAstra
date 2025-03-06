//
//  UserCardNotConnectedView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 19/02/25.
//

import SwiftUI
import Kingfisher

struct UserCardNotConnectedView: View {
    
    @State var user: User
    
    @State var start: UnitPoint = .topLeading
    @State var end: UnitPoint = .bottomTrailing
    
    @Binding var keywordInput: String
    
    var onConnectPressed: () -> Void
    
//    @Binding var userConnected: Bool
    
    @FocusState private var isLabelFocused: Bool
    
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        ZStack {
            VStack{
                
                Spacer()
                    .frame(maxHeight: 12)
                
                if let imageURL = user.profilePictureURL {
                    KFImage(imageURL)
                        .placeholder {
                            CustomSpinnerView()
                                .scaleEffect(0.5)
                        }
                        .resizable()
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .background {
                            Circle()
                                .stroke(Color(.sp), lineWidth: 4)
                        }
                        .padding()
                    
                } else {
                    Image(uiImage: .defaultUserImage())
                        .resizable()
                        .frame(width: 180, height: 180)
                        .clipShape(Circle())
                        .background {
                            Circle()
                                .stroke(Color(.sp), lineWidth: 4)
                        }
                        .padding()
                }
//                Image(uiImage: user.profilePicture)
//                    .resizable()
//                    .frame(width: 132, height: 132)
//                    .clipShape(Circle())
//                    .background {
//                        Circle()
//                            .stroke(Color(.sp), lineWidth: 4)
//                    }
                
                Text(user.name)
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .fontWidth(.expanded)
                
                HStack{
                    ChipTextView(text: user.pronouns)
                    ChipTextView(text: user.getFormattedAge())
                }
                
                Spacer()
                    .frame(maxHeight: 64)
                
                TextField(
                    "",
                    text: $keywordInput,
                    prompt: Text("Enter the user's keyword here")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(red: 0.8, green: 0.72, blue: 0.88))
                )
                    .focused($isLabelFocused)
                    .frame(width: 250, height: 50)
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
                        onConnectPressed()
                    }
                    .submitLabel(.send)
                
                Spacer()
                    .frame(maxHeight: 20)
                
                Button {
                    isLabelFocused = false
                    onConnectPressed()
                } label: {
                    Group {
                        Text("Connect")
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .fontWidth(.expanded)
                    }
                    .frame(width: 180, height: 50)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background { GradientRectangle() }
                }
                .disabled(keywordInput.isEmpty)
                .buttonStyle(PushDownButtonStyle())
                .sensoryFeedback(.success, trigger: session.currentUser?.connectionCount)
                
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
    UserPlanetView(user: .mock)
        .environmentObject(
            SessionStore()
        )
}
