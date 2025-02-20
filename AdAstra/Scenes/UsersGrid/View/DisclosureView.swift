//
//  DisclosureView.swift
//  AdAstra
//
//  Created by Gustavo Binder on 18/02/25.
//

import SwiftUI

struct DisclosureView: View {
    
    let title: String
    let users: [User]
    
    var body: some View {
        DisclosureGroup {
            UsersGridView(users: users, title: title)
        } label: {
            ZStack {
                Text(title)
            }
        }
        .accentColor(.white)
        .padding()
        .fontWeight(.medium)
        .fontWidth(.expanded)
        .foregroundStyle(.white)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.textfield.opacity(0.3))
                .stroke(
                    LinearGradient(
                        colors: [.btf1, .btf2],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
                .shadow(radius: 20.0)
        }
        .padding(.horizontal)
    }
}

#Preview {
//    DisclosureView(viewModel: UsersListViewModel(mock: true), title: "test")
}
