//
//  CardFrontTestView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

// For design & test purposes only:

struct CardFrontTestView: View {
    
    let theWidth: CGFloat
    let theHeight: CGFloat

    var body: some View {
        ZStack {
            //Image("m10")
            
            
            // The border :
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(.purple.opacity(0.7), lineWidth: 3)
                .frame(width: theWidth, height: theHeight)
            
            // The  background :
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.mint.opacity(0.2))
                .frame(width: theWidth, height: theHeight)
                .shadow(color: .gray, radius: 1, x: 0, y: 0)
            
            // The Logo
            Image("m10")
                .resizable()
                .frame(width: theWidth, height: theHeight)
                .foregroundColor(.purple)
            
        } 
        .shadow(radius: 10)

    }
}

#Preview {
    CardFrontTestView(theWidth: 200.0, theHeight: 300.0)
}
