//
//  FavoriteQuotesView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct AllFQsListView: View {
    
    @ObservedObject private var observedFavQuotesVM = FavoriteQuotesVM()
    
    var body: some View {
        ZStack {
            Color.mint.opacity(0.2)
                .ignoresSafeArea() // has to be exactly here, not at the end of the Stack

            VStack {
                Text("My Favorite Quotes")
                    .foregroundColor(.orange)
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
}

    
#Preview {
    AllFQsListView()
}

