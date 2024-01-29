//
//  QuoteFromAPI.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 27.01.24.
//

import SwiftUI

struct APIQuoteView: View {
    
    @StateObject private var quotesVM = QuotesViewModel()

    var body: some View {
        // Filling the variable with data from the VM, triggering an API call by init() of the VM
        let quote = quotesVM.quote.first?.q ?? "API ERROR 404 - Quote"
        let author = quotesVM.quote.first?.a ?? "API ERROR 404 - Author"
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
    }
}

#Preview {
    APIQuoteView()
}
