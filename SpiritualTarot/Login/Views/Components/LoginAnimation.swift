//
//  LoginAnimation.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 13.03.24.
//

import SwiftUI

struct LoginAnimation: View {
    
    @Binding var myDegree: Double

    var body: some View {
        ZStack {
            Image(systemName: "gearshape.arrow.triangle.2.circlepath")
                .resizable()
                .frame(width: 150, height: 150)
            //.shadow(radius: 10)
                .opacity(0.4)
        }
        .rotationEffect(Angle(degrees: myDegree))

    }
}

/*
#Preview {
    LoginAnimation()
}
*/
