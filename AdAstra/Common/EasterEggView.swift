//
//  EasterEggView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 20/02/25.
//

import SwiftUI
import Pow

struct EasterEggView: View {
    @Binding var easterEgg: Bool
    @State var spray = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.p2.opacity(0.9))
                .stroke(
                    LinearGradient(
                        colors: [.btf1, .btf2],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
                .shadow(radius: 10)
            
            VStack(alignment: .center, spacing: 10){
                Text("Ad Astra")
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text("Made with ❤️ by Gustavinhos and Cia.")
                    .font(.system(size: 12, weight: .light, design: .default))
                    .foregroundColor(.white)
                Text("(Afonso, Munhoz, Isoo, Mari e Naomi)")
                    .font(.system(size: 12, weight: .ultraLight, design: .monospaced))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                Button {
                    spray.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        withAnimation(){
                            easterEgg = false
                        }
                    }
                } label: {
                    Group {
                        Text("👍")
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .fontWidth(.expanded)
                            .changeEffect(
                            .spray(origin: UnitPoint(x: 0.25, y: 0.5)) {
                              Image(systemName: "hand.thumbsup.fill")
                                .foregroundStyle(.blue)
                            }, value: spray)
                    }
                    .frame(width: 80, height: 40)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                }
                .background {
                    RoundedRectangle(cornerRadius: 128)
                        .fill(
                            LinearGradient(
                                colors: [.btf1, .btf2],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
            }
            .padding()
        }
        .frame(width: 260, height: 200)
    }
}

#Preview {
    EasterEggView(easterEgg: .constant(true))
}
