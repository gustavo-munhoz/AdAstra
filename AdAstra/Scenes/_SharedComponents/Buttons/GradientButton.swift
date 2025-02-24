//
//  GradientButton.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 23/02/25.
//

import SwiftUI

struct GradientButton: View {
    let title: String
    let loadingTitle: String?
    let isLoading: Bool
    let action: () -> Void
    let disabled: Bool
    
    var body: some View {
        Button(action: action) {
            Group {
                if isLoading {
                    HStack(spacing: 20) {
                        CustomSpinnerView(size: 20)
                        if let loadingTitle = loadingTitle {
                            Text(loadingTitle)
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                                .fontWeight(.medium)
                                .fontWidth(.expanded)
                        }
                    }
                } else {
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .fontWidth(.expanded)
                }
            }
            .frame(width: 180, height: 50)
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            .background { GradientRectangle() }
        }
        .buttonStyle(PushDownButtonStyle())
        .disabled(disabled)
    }
}
