//
//  TransparentCardBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct TransparentCardBTN: View {

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                RoundedRectangle(cornerRadius: 20.0)
                    .stroke(.blue.opacity(0.0), lineWidth: 1)
                    .frame(width: 80  , height: 120)
            }
            //.font(.title)
            //.padding(.vertical, 5)
            //.padding(.horizontal, 10)
            //.foregroundColor(.white)
            //.background(Color.accentColor)
            //.clipShape(Capsule())
            
        }    }
}

#Preview {
    TransparentCardBTN() {}
}
