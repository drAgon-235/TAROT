//
//  CashedQuoteVM.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 27.01.24.
//

import Foundation

class CashedQuoteVM: ObservableObject {
    
    @Published var cashedQuoteToday: CashedQuote = CashedQuote(q: "...", a: "...", date: "date")
    
    func checkDate() {
        
    }
    
    func putToDailyCashe(quote: Quote) {
        self.cashedQuoteToday.q = quote.q
        self.cashedQuoteToday.a = quote.a
        self.cashedQuoteToday.date = getCurrentDate()
    }
    
    
    
    
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy" // MMM: short month name
        return formatter.string(from: Date())
    }
}
