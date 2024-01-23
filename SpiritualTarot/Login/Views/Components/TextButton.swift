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
        
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
        }   
    }
}

#Preview {
    TextButton(title: "Sign in") {}
}
