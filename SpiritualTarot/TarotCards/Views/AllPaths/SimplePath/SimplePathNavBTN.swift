//
//  SimplePathNavBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct SimplePathNavBTN: View {
    var body: some View {
        HStack {
            //Image(systemName: "")
            Text("Simple Path")
        }
        .font(.title)
        .frame(width: 250, height: 50, alignment: .center)
        .background(Color.purple)
        .foregroundColor(Color.white)
        .cornerRadius(10)   
        .padding()
    }
}

#Preview {
    SimplePathNavBTN()
}
