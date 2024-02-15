//
//  TarotSchoolBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 15.02.24.
//

import SwiftUI

struct TarotSchoolBTN: View {
    var body: some View {
        HStack {
            //Image(systemName: "")
            Text("Tarot School")
        }
        .font(.title)
        .frame(width: 250, height: 50, alignment: .center)
        .background(Color.mint)
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    TarotSchoolBTN()
}
