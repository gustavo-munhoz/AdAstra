//
//  ParallaxBackground.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 25/02/25.
//

import SwiftUI

struct ParallaxBackground: View {
    @StateObject private var motionManager = MotionManager()
    
    var body: some View {
        GeometryReader { geometry in
            let maxOffset: CGFloat = 15
            
            let xOffset = CGFloat(motionManager.roll) * maxOffset
            let yOffset = CGFloat(motionManager.pitch) * maxOffset
            
            Image(.bg)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
                .offset(x: xOffset, y: yOffset)
                .frame(
                    width: geometry.size.width + maxOffset * 2,
                    height: geometry.size.height + maxOffset * 2
                )
                .zIndex(2)
        }
        .background {
            Image(.bg)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
        }
    }
}
