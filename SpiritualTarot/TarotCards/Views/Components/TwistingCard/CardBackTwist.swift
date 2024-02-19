//
//  CardBackTwist.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

// used for the shuffeling cards effect

struct CardBackTwist: View {
    
    let theWidth: CGFloat
    let theHeight: CGFloat
    @Binding var myDegree: Double
    
    var body: some View {
        // The borders and backgrounds:
        // The bisser rectanagle:
        ZStack {
            // The purple border (biggest element in back):
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(.purple.opacity(0.9), lineWidth: 3)
                .frame(width: theWidth, height: theHeight)
            
            // the mint margin, also in the back
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.mint.opacity(0.9))
                .frame(width: theWidth, height: theHeight)
                .shadow(color: .gray, radius: 1, x: 0, y: 0)
            
            // The smaller, purple rectangle just gets a padding:
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.purple.opacity(0.2))
                .padding()
                .frame(width: theWidth, height: theHeight)
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(.purple.opacity(0.8), lineWidth: 3)
                .padding()
                .frame(width: theWidth, height: theHeight)
            
            // The '4 circles in a cross' background:
            Image(systemName: "circle.grid.cross")
                .resizable()
                .frame(width: theWidth * 0.8,height: theHeight * 0.85)
                .foregroundColor(.purple.opacity(0.7))

            // The 'seals' in the middle:
            Image(systemName: "seal.fill")
                .resizable()
                .frame(width: theWidth * 0.7,height: theHeight * 0.7)
                .foregroundColor(.white.opacity(0.4))
            
            Image(systemName: "seal")
                .resizable()
                .frame(width: theWidth * 0.6,height: theHeight * 0.6)
                .foregroundColor(.purple.opacity(0.4))
            
            Image(systemName: "seal.fill")
                .resizable()
                .frame(width: theWidth * 0.4,height: theHeight * 0.4)
                .foregroundColor(.purple.opacity(0.7))
            
            // The Sun symbol in the center:
            Image(systemName: "line.3.crossed.swirl.circle.fill")
                .resizable()
                .frame(width: theWidth * 0.2,height: theHeight * 0.2)
                .foregroundColor(.mint)
        }
        // this enables the card to rotate, by $changing the $myDegree variable on call around the definded axis:
        .rotation3DEffect(Angle(degrees: myDegree), axis: (x: 1, y: 0, z: 1))
    }
}


