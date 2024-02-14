//
//  CardFlipTestView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct CardFlipTestView: View {
    
    @StateObject var tarotCardsVM = CardViewModelCoreDB()
    // The @State variables are being "observed"; the degree depends onn the flipping state, which changes ba toggling the Bool (with animation) - this makes the card turn
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped: Bool = false
    
    
    let width: CGFloat
    let height: CGFloat
    let durationAndDelay: CGFloat = 0.5
    
    
    
    func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration:
                durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration:
                durationAndDelay).delay(durationAndDelay)) {
                frontDegree = 0
            }
            
        } else {
            withAnimation(.linear(duration:
                durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration:
                durationAndDelay).delay(durationAndDelay)) {
                backDegree = 0
            }
        }
    }

    
    var body: some View {
        ZStack {
            CardFrontTurn(theWidth: width, theHeight: height, myDegree: $frontDegree, card: tarotCardsVM.allCards.first!)
            CardBackTurn(theWidth: width, theHeight: height, myDegree: $backDegree)
        }
        
        .onTapGesture {
            flipCard()
        }
    }
}

#Preview {
    CardFlipTestView(width: 200, height: 300)
}
