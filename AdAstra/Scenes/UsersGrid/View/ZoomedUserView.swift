//
//  ZoomedUserView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 24/02/25.
//

import SwiftUI

struct ZoomedUserView: View {
    var user: User
    
    var onClosePressed: () -> Void = { }
    
    var body: some View {
        VStack {
            Image(uiImage: user.profilePicture)
                .resizable()
                .frame(width: 180, height: 180)
                .clipShape(Circle())
                .background {
                    Circle()
                        .stroke(Color(.sp), lineWidth: 4)
                }
                .padding()
            
            Text(user.name)
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.medium)
                .fontWidth(.expanded)
            
            Button {
                withAnimation {
                    onClosePressed()
                }
            } label: {
                Text("Close")
                    .frame(width: 270, height: 60)
                    .foregroundStyle(.white)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .fontWidth(.expanded)
                    .background {
                        GradientRectangle()
                    }
            }
            .buttonStyle(PushDownButtonStyle())
        }
        .frame(width: 350, height: 400)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.dp.opacity(0.95))
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
