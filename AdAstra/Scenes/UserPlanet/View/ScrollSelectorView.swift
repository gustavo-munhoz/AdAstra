//
//  ScrollSelectorView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 13/02/25.
//

import SwiftUI
import SceneKit

struct ScrollSelectorView: View {
    let scaleFactor = 0.55
    let offsetValue = 80
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
        ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(1..<68, id: \.self) { i in
                        ZStack(alignment: .center){
                            planetViews[i]
                                .frame(height: 150)
                                .scaleEffect(scaleCalc(index: i))
                                .offset(x: offsetCalc(index:i))
                                .animation(.snappy, value: value.wrappedValue)
                            
                            Text("\(i)")
                                .scaleEffect(scaleCalc(index: i))
                                .offset(y: -offsetCalc(index:i))
                                .animation(.snappy, value: value)
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
            .scrollIndicators(.hidden)
            .safeAreaPadding(125)
            .overlay(alignment: .center, content: {
                Rectangle()
                    .frame(width: 1, height: 100, alignment: .center)
            })
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
        return (1.0 - (distance * Double(offsetValue))) // Ensures it gets smaller the further it is
    }
}

#Preview {
    UserPlanetView()
}
