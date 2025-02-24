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
    
//    @State var start: UnitPoint = .topLeading
//    @State var end: UnitPoint = .bottomTrailing
//    
//    @State var isFlipped: Bool = false
//    
//    @State var userConnected: Bool = false
    
    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.p2.opacity(0.8))
//                .stroke(
//                    LinearGradient(
//                        colors: [.btf1, .btf2],
//                        startPoint: start,
//                        endPoint: end
//                    ),
//                    lineWidth: 1
//                )
//                .shadow(radius: 10)
//            
//            if isFlipped{
        ScrollView(.vertical){
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
                        
                        //Tags
                        ScrollView(.horizontal){
                            HStack(spacing: 8){
                                ChipTextView(text: user.pronouns)
                                ChipTextView(text: "\(user.age) anos") //user.age
                                ChipTextView(text: user.role.localized) //user.role
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
                }
//
//            } else {
//                UserCardNotConnectedView(user: user)
//                    .frame(width: 300, height: 450)
//            }
//        }
//        .frame(width: 350, height: 500)
//        .rotation3DEffect(Angle(degrees: isFlipped ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
//        .scaleEffect(scaleAnimation)
//        .onChange(of: userConnected) {
//            rotate()
//            scale()
//        }
//        .padding(20)
//        .cornerRadius(20)
    }
    
//    func rotate(){
//        withAnimation(.linear(duration: 0.5)){
//            isFlipped.toggle()
//        }
//    }
//    
//    func scale(){
//        withAnimation(.easeInOut(duration: 0.2)){
//            scaleAnimation = 0.5
//        }
//        withAnimation(.easeInOut(duration: 0.2).delay(0.2)){
//            scaleAnimation = 1.0
//        }
//    }
    
    func interests() -> String {
        var interests = ""
        for interest in user.interests{
            interests+="\(interest), "
        }
        
        interests.removeLast(2)
        
        return interests
    }
}

#Preview {
    UserCardConnectedView(user: .mock)
}
