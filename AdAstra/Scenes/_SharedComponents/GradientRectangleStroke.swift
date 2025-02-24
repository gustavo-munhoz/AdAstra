//
//  GradientRectangleStroke.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 23/02/25.
//

import SwiftUI

struct GradientRectangleStroke: View {
    
    let cornerRadius: CGFloat = 128
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.textfield.opacity(0.1))
            .stroke(
                LinearGradient(
                    colors: [.btf1, .btf2],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 1
            )
    }
}
