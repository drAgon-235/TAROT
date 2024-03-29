//
//  CardOfTheDayBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct CardOfTheDayBTN: View {
    
    let action: () -> Void

    var body: some View {
        
        Button(action: action) {
            HStack {
                //Image(systemName: "")
                Text("Daily / random Card")
            }
            .font(.title)
            .frame(width: 250, height: 50, alignment: .center)
            .background(Color.purple)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .padding()
            .shadow(radius: 10)

        }
    }
}

#Preview {
    CardOfTheDayBTN() {}
}
