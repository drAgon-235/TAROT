//
//  QuoteFromAPI.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 27.01.24.
//

import SwiftUI

struct APIQuoteView: View {
    
    
    
    @StateObject private var quotesVM = QuotesViewModel()
    @StateObject private var casheVM = CashedQuoteVM()
    
    
    var body: some View {
        // Filling the variable with data from the VM, triggering an API call by init() of the VM
        let quote = quotesVM.quote.first?.q ?? "API ERROR 404 - Quote"
        let author = quotesVM.quote.first?.a ?? "API ERROR 404 - Author"
        let casheQuote = quote
        let casheAuthor = author
        
        VStack {
            
            Text(quote)
                .font(.title2)
                .foregroundColor(.white)
            Divider()
            Text(author)
                .padding(4)
                .foregroundColor(.purple)
        }
        .padding()
        .background(Color.mint)
        .cornerRadius(10)
        .padding()
        
        /*
        // WTF
        .onTapGesture {
            casheVM.putToDailyCashe(quote: Quote(q: casheQuote, a: casheAuthor))
        }
         */
        
    }
        
}

#Preview {
    APIQuoteView()
}
