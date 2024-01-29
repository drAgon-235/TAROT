//
//  QuoteFromCashe.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 27.01.24.
//

import SwiftUI

// just for Testing purposals:
struct CasheQuoteView: View {
    
    @StateObject private var cashVM = CashedQuoteVM()


    
    var body: some View {
        let quote = cashVM.cashedQuoteToday.first!.q
        let author = cashVM.cashedQuoteToday.first!.a
        
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
    CasheQuoteView()
}
