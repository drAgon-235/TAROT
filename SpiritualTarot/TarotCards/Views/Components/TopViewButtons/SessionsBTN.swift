//
//  AllPathsBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct SessionsBTN: View {
    var body: some View {
        HStack {
            //Image(systemName: "")
            Text("Laying Sessions")
        }
        .font(.title)
        .frame(width: 250, height: 50, alignment: .center)
        .background(Color.blue)
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    SessionsBTN()
}
