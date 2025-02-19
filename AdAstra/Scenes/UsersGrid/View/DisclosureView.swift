//
//  DisclosureView.swift
//  AdAstra
//
//  Created by Gustavo Binder on 18/02/25.
//

import SwiftUI

struct DisclosureView: View {
    
//    @StateObject var viewModel: UsersGridViewModel
    @EnvironmentObject var viewModel : UsersGridViewModel
    let title : String
    
//    init(_ title: String, viewModel: UsersGridViewModel) {
//        self.title = title
//        self.viewModel = viewModel
//    }
    
    var body: some View {
        DisclosureGroup {
            UsersGridView()
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
                .stroke(LinearGradient(colors: [.btf1, .btf2], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
                .shadow(radius: 20.0)
        }
        .padding(.horizontal)
    }
}

#Preview {
//    DisclosureView(viewModel: UsersGridViewModel(mock: true), title: "test")
}
