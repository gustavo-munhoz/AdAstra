//
//  PushDownButtonStyle.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 23/02/25.
//

import SwiftUI

struct PushDownButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    var cornerRadius: CGFloat = 128
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(
                {
                    if !isEnabled { 0.5 }
                    else if configuration.isPressed { 0.75 }
                    else { 1 }
                }()
            )
            .conditionalEffect(.pushDown, condition: configuration.isPressed)
    }
}
