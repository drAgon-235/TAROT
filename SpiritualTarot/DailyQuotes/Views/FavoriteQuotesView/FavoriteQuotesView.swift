//
//  FavoriteQuotesView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct FavoriteQuotesView: View {
    
    @ObservedObject private var observedFavQuotesVM = FavoriteQuotesVM()
    
    var body: some View {
        Text("My Favorite Quotes")
            .foregroundColor(.purple)
            .font(.title)
        
            List(observedFavQuotesVM.favQuotes) { favoriteQuote in
                OneFQItemView(favQuote: favoriteQuote)
                //.padding(.horizontal, 20)
                    .swipeActions {
                        Button(role: .destructive) {
                            observedFavQuotesVM.deleteFavQuote(with: favoriteQuote.id!)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
            
            /* here the swipesActions didn't work : ?!?!?!??
             ScrollView(showsIndicators: false) {
             VStack {
             ForEach(favQuotesVM.favQuotes) { favoriteQuote in
             
             OneFQItemView(favQuote: favoriteQuote)
             //.padding(.horizontal, 20)
             .swipeActions {
             Button(role: .destructive) {
             observedFavQuotesVM.deleteFavQuote(with: favoriteQuote.id!)
             } label: {
             Label("Delete", systemImage: "trash")
             }
             
             
             }
             }
             }
             }
             */
            
        }
    }

    
#Preview {
    FavoriteQuotesView()
}

