//
//  ReadingDefaultBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 15.02.24.
//

import SwiftUI

struct ReadingDefaultBTN: View {
    
    let text: String

    var body: some View {
        HStack {
            //Image(systemName: "")
            Text(text)
        }
        .font(.title)
        .frame(width: 250, height: 50, alignment: .center)
        .background(Color.blue)
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .padding()
        .shadow(radius: 10)

    }
}

#Preview {
    ReadingDefaultBTN(text: "Laying Session")
}
