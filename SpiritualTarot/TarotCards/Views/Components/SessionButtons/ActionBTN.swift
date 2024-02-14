//
//  ActionBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct ActionBTN: View {
    
    let text: String
    let action: () -> Void
    let action_02: () -> Void
    let action_03: () -> Void

    var body: some View {
        
        Button {
            action()
            action_02()
            action_03()
            print("ActionBTN O.K.  e.g.")
        } label: {
            Text(text)
        }
        .tint(.white)  // text color
        
        .background(
            Capsule()
                .foregroundColor(Color(red: 0 / 255, green: 0 / 255, blue: 250 / 255))
                .frame(width: 120, height: 40)
        )
        //.padding()
        
    }
}

#Preview {
    ActionBTN(text: "Test", action: {}, action_02: {}) {}
}
