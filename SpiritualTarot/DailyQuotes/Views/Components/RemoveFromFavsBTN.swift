//
//  RemoveFromFavsBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct RemoveFromFavsBTN: View {
    
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: "heart.fill")
                
                Text("")
            }
            .font(.title)
            //.padding(.vertical, 5)
            //.padding(.horizontal, 10)
            //.foregroundColor(.white)
            //.background(Color.accentColor)
            //.clipShape(Capsule())
            
        }
    }
}

#Preview {
    RemoveFromFavsBTN() {}
}
