//
//  QuoteTopView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct QuoteTopView: View {
        
    // manage the changing to other Views with toggles
    @State var showQuoteView = false
    @State var showFavoritesView = false
    
    var body: some View {
        NavigationStack{
            VStack {
                Button(action: {showQuoteView.toggle()}, label: {
                    HStack(spacing: 10) {
                        Image(systemName: "quote.bubble")
                        Text("Quote of the day")
                    }
                    .frame(minWidth: 0)
                    .font(.title)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                })
                .padding(40)
                
                NavigationLink(destination: FavoriteQuotesView()) {
                    ShowFavBTN()
                }.navigationBarTitle(Text("Daily stuff"))
            }
        }
        // sheet for Quote of the Day
        .sheet( isPresented: $showQuoteView){
            QuoteView()
            Button("Close"){ showQuoteView.toggle() }
            Spacer()
        }
    }
}

#Preview {
    QuoteTopView()
}
