//
//  TextButton.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct TextButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        
        VStack {
            Button(action: action) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(5)
            }
        }
        .background(.mint)
        .cornerRadius(5)
        .shadow(radius: 10)


    }
}

#Preview {
    TextButton(title: "Sign in") {}
}
