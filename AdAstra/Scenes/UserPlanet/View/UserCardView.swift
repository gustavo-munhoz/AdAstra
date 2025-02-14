//
//  UserCardView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 13/02/25.
//

import SwiftUI

struct UserCardView: View {
    let data: String
    var body: some View {
        VStack{
            Text(data)
                .font(.system(size: 20))
        }
        .frame(width: 300)
        .background(Color(white: 255/255, opacity: 0.8))
    }
}
