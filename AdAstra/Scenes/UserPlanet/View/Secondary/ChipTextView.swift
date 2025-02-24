//
//  ChipTextView.swift
//  AdAstra
//
//  Created by Afonso Rekbaim on 18/02/25.
//

import SwiftUI

struct ChipTextView: View {
    let text: String
    var body: some View {
        ZStack{
            Text(text)
                .foregroundStyle(.logo)
                .font(.system(size: 12))
                .fontWeight(.medium)
                .fontWidth(.expanded)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.sp, lineWidth: 1)
                .fill(.sp.opacity(0.1))
        }
    }
}

#Preview {
    ChipTextView(text: "ela/dela")
}
