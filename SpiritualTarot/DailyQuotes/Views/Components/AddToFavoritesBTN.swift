//
//  AddToFavoritesBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct AddToFavoritesBTN: View {
    
    
    let action: () -> Void

    var body: some View {

        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: "heart")
                
                Text("")
            }
            .font(.title)
            //.padding(.vertical, 5)
            //.padding(.horizontal, 10)
            .foregroundColor(.purple)
            //.background(Color.accentColor)
            //.clipShape(Capsule())
        }
        
    }
}

#Preview {
    AddToFavoritesBTN() {}
}
