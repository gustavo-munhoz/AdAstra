//
//  ScrollSelectorView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 13/02/25.
//

import SwiftUI
import SceneKit

struct ScrollSelectorView: View {
    let scaleFactor = 0.25
    let scaleFactorImage = 0.15
    let offsetValue = 40
    let offsetValueImage = 10
    var value: Binding<Int>
    var numUsers : Int
    var users : [User]
    
    init(value: Binding<Int>, numberOfUsers: Int, users: [User]) {
        self.value = value
        self.numUsers = numberOfUsers
        self.users = users
    }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0..<numUsers, id: \.self) { i in
                    ZStack {
                        VStack(spacing: 0) {
                            ZStack {
                                Circle()
                                    .frame(width: 120, height: 120)
                                    .border(.red)
                                    .foregroundStyle(
                                        opacityCalc(
                                            index: i,
                                            gradient: users[i].planet.gradientName
                                        )
                                    )
                                    .blur(radius: 20)
                                
                                TDPlanetView(users[i])
                                    .frame(width: 150, height: 180)
                                
                                Image(uiImage: users[i].profilePicture)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .background {
                                        Circle()
                                            .stroke(
                                                LinearGradient(
                                                    colors: [.btf1, .btf2],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 4
                                            )
                                    }
                                    .offset(x: 0, y: 50)
                            }
                        }
                        .scaleEffect(scaleCalc(index: i))
                        .offset(y: -offsetCalc(index: i))
                        .animation(.default, value: value.wrappedValue)
                    }
                }
            }
            .offset(y: -30)
            .frame(height: 230)
            .scrollTargetLayout()
            .padding(.top, 24)
        }
        .offset(y: 0)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: .init(get: {
            let position: Int = value.wrappedValue
            return position
        }, set: { newValue in
            if let newValue { value.wrappedValue = newValue }
        }))
        .scrollIndicators(.hidden)
        .safeAreaPadding(125)
    }
    
    func scaleCalc(index: Int) -> Double {
        let distance = abs(Double(index) - Double(value.wrappedValue))
        var scaleFinal = 1.0 - (distance * scaleFactor)
        if scaleFinal < 0.35 {
            scaleFinal = 0.35
        }
        return scaleFinal
    }
    func scaleCalcImage(index: Int) -> Double {
        let distance = abs(Double(index) - Double(value.wrappedValue))
        var scaleFinal = 1.0 - (distance * scaleFactorImage)
        if scaleFinal < 0.35 {
            scaleFinal = 0.35
        }
        return scaleFinal
    }
    
    func offsetCalc(index: Int) -> Double {
        let distance = abs(Double(index) - Double(value.wrappedValue))
        return (0.8 - (distance * Double(offsetValue)))
    }
    
    func offsetCalcImage(index: Int) -> Double {
        let distance = abs(Double(index) - Double(value.wrappedValue))
        return (1.5 - (distance * Double(offsetValueImage)))
    }
    
    func opacityCalc(index: Int, gradient: GradientName) -> Color {
        Color(uiColor: UIColor(named: gradient.rawValue)!)
            .opacity(index == value.wrappedValue ? 1 : 0.4)
    }
}

//#Preview {
//    UserPlanetView()
//}
