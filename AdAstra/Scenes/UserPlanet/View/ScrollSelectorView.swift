//
//  ScrollSelectorView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 13/02/25.
//

import SwiftUI

struct ScrollSelectorView: View {
    let scaleFactor = 0.45
    let offsetValue = -40
    @Binding var value: Int

    var body: some View {
        HStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(0..<10, id: \.self) { i in
                        ZStack {
                            Circle()
                                .fill(Color(hue: Double(i) / 10, saturation: 1, brightness: 1).gradient)
                                .frame(height: 150)
                                .scaleEffect(scaleCalc(index: i))
                                .offset(x: offsetCalc(index:i))
                                .animation(.snappy, value: value)
                            
                            Text("\(i)")
                                .scaleEffect(scaleCalc(index: i))
                                .offset(x: offsetCalc(index:i))
                                .animation(.snappy, value: value)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: .init(get: {
                let position: Int = value
                return position
            }, set: { newValue in
                if let newValue { value = newValue }
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
        let distance = abs(Double(index) - Double(value))
        return 1.0 - (distance * scaleFactor) // Ensures it gets smaller the further it is
    }
    
    func offsetCalc(index: Int) -> Double {
        let distance = abs(Double(index) - Double(value))
        return -(1.0 - (distance * Double(offsetValue))) // Ensures it gets smaller the further it is
    }
}

#Preview {
    UserPlanetView()
}
