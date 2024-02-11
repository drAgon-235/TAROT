//
//  QuoteTopView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct QuoteTopView: View {
        
    @StateObject private var quotesVM = QuotesViewModel()

    // manage the changing to other Views with toggles
    @State var showQuoteView = false
    
    
    var body: some View {
        NavigationStack{
            VStack {
                Button(action: {
                    showQuoteView.toggle()}, label: {
                    HStack(spacing: 10) {
                        Image(systemName: "quote.bubble")
                        Text("Quote of the day")
                    }
                    .frame(minWidth: 0)
                    .font(.title)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .foregroundColor(.white)
                    .background(Color.mint)
                    .cornerRadius(10)
                })
                .padding(40)
                
                
                
                
                NavigationLink(destination: FavoriteQuotesView()) {
                    ShowFavBTN()
                }
                .navigationBarTitle(Text("Daily quotes"))
                .toolbar {
                    HStack {
                        Spacer()
                        LogoutButtonAlert()
                    }
                }
  
                
            }
        }
        // sheet for Quote of the Day
        .sheet( isPresented: $showQuoteView){
            QuoteView()
                .modelContainer(for: [Quote.self])
            
            Button("Close"){ showQuoteView.toggle() }
            Spacer()
        }
    }
}

#Preview {
    QuoteTopView()
}
