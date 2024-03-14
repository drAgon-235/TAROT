//
//  LoginAnimTEST.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 13.03.24.
//

import SwiftUI

struct LoginAnimTEST: View {
    
    @State var thisDegree = 0.0
    @State var isTurned: Bool = false
    
    func turnWheel() {
            isTurned.toggle()
            if isTurned {
                withAnimation() {
                    thisDegree = 360
                }
            } else {
                withAnimation() {
                    thisDegree = 0
                }
            }
        }
    
    
    var body: some View {
        LoginAnimation(myDegree: $thisDegree)
        
        Button(action: {
            turnWheel()
        }, label: {
            Text("Turn the Wheel")
                .font(.title)
                .padding(.top, 70)
        })
    }
}

#Preview {
    LoginAnimTEST()
}
