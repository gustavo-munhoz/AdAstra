//
//  ScrollSelectorView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 13/02/25.
//

import SwiftUI
import SceneKit

struct ScrollSelectorView: View {
    let scaleFactor = 0.45
    let offsetValue = -40
    var value: Binding<Int>
    
    var planetViews : [TDPlanetView]
    
    init(value: Binding<Int>) {
        self.value = value
        self.planetViews = []
        
        for _ in 0..<10 {
            planetViews.append(TDPlanetView())
        }
    }
    
    var body: some View {
        HStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(0..<10, id:\.self) { i in
                        ZStack {
                            planetViews[i]
                                .frame(height: 150)
                                .scaleEffect(scaleCalc(index: i))
                                .offset(x: offsetCalc(index:i))
                                .animation(.snappy, value: value.wrappedValue)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: .init(get: {
                let position: Int = value.wrappedValue
                return position
            }, set: { newValue in
                if let newValue { value.wrappedValue = newValue }
            }))
            .safeAreaPadding(150)
            .overlay(alignment: .center, content: {
                Rectangle()
                    .frame(width: 100, height: 1, alignment: .center)
            })
            
            Spacer()
        }
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
//        return -(1.0 - (distance * Double(offsetValue))) // Ensures it gets smaller the further it is
        return distance * Double(offsetValue)
    }
}

#Preview {
    UserPlanetView()
}
