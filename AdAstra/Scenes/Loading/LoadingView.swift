//
//  LoadingView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 22/02/25.
//

import SwiftUI

struct LoadingView: View {
    var loadingText: String?
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                LogoView()
                    .scaleEffect(CGSize(width: 0.5, height: 0.5))
                    .padding(.vertical)
                
                CustomSpinnerView(loadingText: loadingText)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
        }
        .transition(.opacity)
        .animation(.easeInOut, value: UUID())
    }
}

