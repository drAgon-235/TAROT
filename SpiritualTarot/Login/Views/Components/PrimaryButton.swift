//
//  PrimaryButton.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct PrimaryButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                Text(title)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)

            }
            .padding(.vertical, 12)
            .background(Color.accentColor)
            .cornerRadius(12)
            .shadow(radius: 10)
        }

    }
}

#Preview {
    PrimaryButton(title: "Login") { }
}
