//
//  TDPlanetView.swift
//  AdAstra
//
//  Created by Gustavo Binder on 16/02/25.
//

import SwiftUI
import SceneKit

struct TDPlanetView: View, Identifiable {
    var id: UUID = UUID()
    
    @ObservedObject var viewModel: PlanetViewModel
    @Binding var isPlanetRevealed: Bool

    init(
        user: User,
        isPlanetRevealed: Binding<Bool>,
        viewModelStore: PlanetViewModelStore
    ) {
        self._isPlanetRevealed = isPlanetRevealed
        self.viewModel = viewModelStore.model(for: user)
    }
    
    var body: some View {
        ScenePlanetView(sceneHolder: viewModel.sceneHolder)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(Circle())
            .overlay(
                GeometryReader { geo in
                    if !isPlanetRevealed {
                        let diameter = min(geo.size.width, geo.size.height) * 0.68
                        
                        Circle()
                            .fill(Color.black.opacity(0.8))
                            .frame(width: diameter, height: diameter)
                            .position(x: geo.size.width / 2, y: geo.size.height / 2)
                            .transition(.opacity)
                    }
                }
                    .animation(.easeInOut, value: isPlanetRevealed)
            )
    }
}

