//
//  SolarSystemView.swift
//  AdAstra
//
//  Created by Gustavo Munhoz Correa on 12/02/25.
//

import SwiftUI
import SceneKit

struct SolarSystemView: View {
    
    let layout = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
    ]
    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: layout){
                ForEach(1..<68) { i in
                    NavigationLink {
//                        UserPlanetView(user: User)
                    } label: {
                        ZStack{
                            Rectangle()
                                .frame(width: 70, height: 70)
                        }
                    }
                }
            }
        }
        .background(.black)
    }
}

#Preview {
    SolarSystemView()
}
