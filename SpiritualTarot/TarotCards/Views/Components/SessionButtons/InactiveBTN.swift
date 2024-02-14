//
//  InactiveBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct InactiveBTN: View {

    let text: String

    var body: some View {
        
        Text(text)
            .foregroundColor(.white)  // text color
        .background(
            Capsule()
                .foregroundColor(Color.gray.opacity(0.5))
                .frame(width: 120, height: 40)
        )
        //.padding()  
    }
}

#Preview {
    InactiveBTN(text: "Inactive")
}
