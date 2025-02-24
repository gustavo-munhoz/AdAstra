//
//  CustomSpinnerView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 22/02/25.
//

import SwiftUI

struct CustomSpinnerView: View {
    var loadingText: String? = nil

    @State private var startTrim: CGFloat = 0.0
    @State private var endTrim: CGFloat = 0.1
    @State private var rotation: Double = 0

    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .trim(from: startTrim, to: endTrim)
                .stroke(.gradientWhite1, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .frame(width: 28, height: 28)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                    withAnimation(Animation.easeOut(duration: 1.0).repeatForever(autoreverses: true)) {
                        endTrim = 0.75
                    }
                    withAnimation(Animation.easeIn(duration: 1.0).repeatForever(autoreverses: true)) {
                        startTrim = 0.1
                    }
                }
                        
            if let loadingText {
                Text(loadingText)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gradientWhite1)
                    .fontWidth(.expanded)
            }
        }
    }
}
 
