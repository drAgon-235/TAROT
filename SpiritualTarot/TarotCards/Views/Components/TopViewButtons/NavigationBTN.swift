//
//  AllPathsBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct NavigationBTN: View {
    
    var text: String
    var color: Color
    
    var body: some View {
        HStack {
            //Image(systemName: "")
            Text(text)
        }
        .font(.title)
        .frame(width: 250, height: 50, alignment: .center)
        .background(color)
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .padding()
        .shadow(radius: 10)
    }
}

#Preview {
    NavigationBTN(text: "TEst Button", color: Color.red)
}
