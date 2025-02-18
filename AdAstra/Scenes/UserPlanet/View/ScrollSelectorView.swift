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
    let offsetValue = 40
    var value: Binding<Int>
                          
    var planetViews : [TDPlanetView]
    
    init(value: Binding<Int>) {
        self.value = value
        self.planetViews = []
        
        for _ in 1..<68 {
            planetViews.append(TDPlanetView())
        }
    }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(1..<68, id: \.self) { i in
                    ZStack(alignment: .center){
                        Circle()
                            .frame(width: 120, height: 120)
                            .border(.red)
                            .scaleEffect(scaleCalc(index: i))
                            .offset(y: -offsetCalc(index:i))
                            .animation(.default, value: value.wrappedValue)
                            .foregroundStyle(opacityCalc(index: i))
                            .blur(radius: 20)
                        planetViews[i]
                            .frame(width: 150, height: 180)
                            .scaleEffect(scaleCalc(index: i))
                            .offset(y: -offsetCalc(index:i))
                            .animation(.default, value: value.wrappedValue)
                        
//                        Text("\(i)")
//                            .scaleEffect(scaleCalc(index: i))
//                            .offset(y: -offsetCalc(index:i))
//                            .animation(.snappy, value: value.wrappedValue)
                    }
                }
            }
            .offset(y: -30)
            .frame(height: 230)
            .scrollTargetLayout()
//            .border(.red, width: 10)
            .padding(.top, 24)
        }
        .offset(y: 60)
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: .init(get: {
            let position: Int = value.wrappedValue
            return position
        }, set: { newValue in
            if let newValue { value.wrappedValue = newValue }
        }))
        .scrollIndicators(.hidden)
        .safeAreaPadding(125)
//        .overlay(alignment: .center, content: {
//            Rectangle()
//                .frame(width: 1, height: 100, alignment: .center)
//        })
    }
    
    func scaleCalc(index: Int) -> Double {
        let distance = abs(Double(index) - Double(value.wrappedValue))
        var scaleFinal = 1.0 - (distance * scaleFactor)
        if scaleFinal < 0.35 {
            scaleFinal = 0.35
        }
        return scaleFinal // Ensures it gets smaller the further it is
    }
    
    func offsetCalc(index: Int) -> Double {
        let distance = abs(Double(index) - Double(value.wrappedValue))
        return (1.5 - (distance * Double(offsetValue))) // Ensures it gets smaller the further it is
    }
    
    func opacityCalc(index: Int) -> Color {
        return index == value.wrappedValue ? Color.white : Color.white.opacity(0.4) // Ensures it gets smaller the further it is
    }
}

#Preview {
    UserPlanetView()
}
