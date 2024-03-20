//
//  CardBackTestView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct CardBackTestView: View {
    
    let theWidth: CGFloat
    let theHeight: CGFloat

    var body: some View {
        
        // The borders and backgrounds:
        // The rectanagle:
        ZStack {
 
            // the mint margin, also in the back
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.mint.opacity(0.2))
                .frame(width: 400, height: 500)
                .shadow(color: .gray, radius: 1, x: 0, y: 0)
            
            // The smaller, purple rectangle just gets a padding:
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.purple.opacity(0.5))
                .padding()
                .frame(width: theWidth, height: theHeight)
            RoundedRectangle(cornerRadius: 20.0)
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
                .foregroundColor(.orange.opacity(0.9))
            
            Image(systemName: "seal.fill")
                .resizable()
                .frame(width: theWidth * 0.4,height: theHeight * 0.4)
                .foregroundColor(.purple.opacity(0.7))
            
            // The Sun symbol in the center:
            Image(systemName: "line.3.crossed.swirl.circle.fill")
                .resizable()
                .frame(width: theWidth * 0.2,height: theHeight * 0.2)
                .foregroundColor(.mint)
        }    }
}

#Preview {
    CardBackTestView(theWidth: 200.0, theHeight: 300.0)
}
