//
//  Repo_TestView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import SwiftUI

struct Repo_TestView: View {

    @StateObject var cardsVM = TarotCardsRepo()

    var body: some View {
        
        List(cardsVM.cardsList) { card in
            HStack {
                Text("\(card.id)")
                Text(card.name)
                Spacer()
                Image(card.image)
                    .resizable()
                    .frame(width: 50, height: 100)
            }
        }

    }
}

#Preview {
    Repo_TestView()
}
