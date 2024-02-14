//
//  CardFrontTurn.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

// used for the turnig effect while showing the cards

struct CardFrontTurn: View {
    
    let theWidth: CGFloat
    let theHeight: CGFloat
    @Binding var myDegree: Double
    let card: Card

    var body: some View {
        
        ZStack {
            // The borders and backgrounds:
            
            RoundedRectangle(cornerRadius: 20.0)
                .stroke(.purple.opacity(0.7), lineWidth: 3)
                .frame(width: theWidth, height: theHeight)
            
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.mint.opacity(0.2))
                .frame(width: theWidth, height: theHeight)
                .shadow(color: .gray, radius: 1, x: 0, y: 0)
            
            Image(card.image!)
                .resizable()
                .frame(width: theWidth - 5, height: theHeight - 5)
                .foregroundColor(.purple)
        }
        // this enables the card to rotate, by $changing the $myDegree variable on call around the definded axis:
        .rotation3DEffect(Angle(degrees: myDegree), axis: (x: 0, y: 1, z: 0))
    }
}

/*
#Preview {
    CardFrontTurn()
}
*/
