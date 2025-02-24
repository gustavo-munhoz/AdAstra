//
//  GradientRectangle.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 23/02/25.
//

import SwiftUI

struct GradientRectangle: View {
    
    var cornerRadius: CGFloat = 128
    var animated: Bool = true
    
    var body: some View {
        ZStack {
            if animated, #available(iOS 18.0, *) {
                TimelineView(.animation) { timeline in
                    let time = timeline.date.timeIntervalSince1970
                    
                    let animatedX0 = Float(sin(time)) * 0.05
                    let animatedX1 = Float(cos(time)) * 0.15
                    let animatedX2 = Float(sin(time)) * 0.1

                    let animatedY0 = Float((cos(time + 1) + 1) / 2)
                    let animatedY1 = Float((sin(time - 2) + 0.75) / 2)
                    let animatedY2 = Float((cos(time - 0.85) + 1) / 2)
                    
                    MeshGradient(
                        width: 3,
                        height: 3,
                        points: [
                            [0 - abs(animatedX0), 0 - abs(animatedY0)], [0.5 + animatedX1, 0 - abs(animatedY2)], [1 + abs(animatedX2), 0 - abs(animatedY1)],
                            [0 - abs(animatedX0), animatedY0], [0.5 + animatedX1, animatedY1], [1 + abs(animatedX2), animatedY2],
                            [0 - abs(animatedX2), 1 + abs(animatedY2)], [0.5 + animatedX1, 1 + abs(animatedY0)], [1 + abs(animatedX2), 1 + abs(animatedY1)]
                        ],
                        colors: [
                            .btf1, .btf1, .btf2,
                            .btf1, .btf1, .btf2,
                            .btf2, .btf2, .btf1
                        ]
                    )
                }
                
            } else {
                LinearGradient(
                    colors: [.btf1, .btf2],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
        .mask {
            RoundedRectangle(cornerRadius: cornerRadius)
        }
    }
}

#Preview {
    GradientRectangle()
        .frame(height: 140)
}
