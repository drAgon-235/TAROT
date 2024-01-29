//
//  CashedQuoteVM.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 27.01.24.
//

import Foundation

class CashedQuoteVM: ObservableObject {
    
    
    @Published var cashedQuoteToday: [CashedQuote] = [CashedQuote(q: "...", a: "...", date: "date")]
    
    
    func putToDailyCashe(quote: CashedQuote) {
        self.cashedQuoteToday[0] = CashedQuote(q: quote.q, a: quote.a, date: quote.date)
    }
    
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy" // MMM: short month name
        return formatter.string(from: Date())
    }
    
    /*
    func containsQuote(_ quote: String) -> Bool {
        cashedQuoteToday.q == quote
    }
    
    func isCurrentDateSameAsCashed() -> Bool {
        cashedQuoteToday.date == getCurrentDate()
    }
     */
}
