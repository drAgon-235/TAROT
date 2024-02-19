//
//  OneFQItemView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 24.01.24.
//

import SwiftUI

struct OneFQItemView: View {
    
    let favQuote: FavoriteQuote
    
    var body: some View {
       
            VStack {
                //Only padding to top, for the Divider() already "has" an own padding by default
                Text(favQuote.q)
                    .padding(.top, 8)
                    .padding(.horizontal, 5)
                    .font(.title3)
                    .foregroundColor(.white)
                
                Divider()
                
                //Only padding to bottom, for the Divider() already "has" an own padding by default
                Text(favQuote.a)
                    .padding(.bottom, 8)
                    .foregroundColor(.purple)
            }
            //.padding(8)
            .background(Color.mint)
            .cornerRadius(10)
            .shadow(radius: 8)

            //.padding()
            
    }
}

#Preview {
    OneFQItemView(favQuote: FavoriteQuote(userID: "123", q: "Any words without meaning but lot of nonsense", a: "Anonymous", isFavorite: true))
}
