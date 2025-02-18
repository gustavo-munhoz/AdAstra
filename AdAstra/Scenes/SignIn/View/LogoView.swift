//
//  LogoView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 17/02/25.
//

import SwiftUI

struct LogoView: View {
    @State var offsetY: CGFloat = 12.0
    @State var offsetX: CGFloat = 0.0
    @State var radius: CGFloat = 10.0
    @State var rotation: CGFloat = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: -30){
            HStack{
                Text("ad")
                    .font(.system(size: 62))
                    .fontWeight(.medium)
                    .fontWidth(.expanded)
                    .foregroundStyle(.logo)
                ZStack{
                    Text("*")
                        .font(.system(size: 62))
                        .fontWeight(.medium)
                        .fontWidth(.expanded)
                        .foregroundStyle(.white)
                        .offset(x: offsetX, y: offsetY)
                        .blur(radius: radius)
                        .opacity(0.5)
                        .rotationEffect(Angle(degrees: rotation))
                    
                    Text("*")
                        .font(.system(size: 62))
                        .fontWeight(.medium)
                        .fontWidth(.expanded)
                        .foregroundStyle(.logo)
                        .offset(x: offsetX, y: offsetY)
                        .rotationEffect(Angle(degrees: rotation))
                }
                .onAppear{
                    withAnimation(.linear(duration: 1).delay(1).repeatForever(autoreverses: true)){
                        offsetY = 10.0
                    }
                    withAnimation(.linear(duration: 0.5).delay(0.5).repeatForever(autoreverses: true)){
                        offsetX = 20.0
                    }
                    
                    withAnimation(.bouncy(duration: 4).repeatForever(autoreverses: true)){
                        radius = 5
                        rotation = 360
                    }
                }
            }
            Text("astra")
                .font(.system(size: 62))
                .fontWeight(.medium)
                .fontWidth(.expanded)
                .foregroundStyle(.logo)
        }
    }
}

#Preview {
    LogoView()
}
