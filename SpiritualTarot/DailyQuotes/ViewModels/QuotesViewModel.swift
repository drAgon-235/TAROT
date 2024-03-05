//
//  QuotesViewModel.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation

// The SwiftData actually is the VewModel

class QuotesViewModel: ObservableObject {
    
    // The tricky part is, that the JSON call gives a List[Quote] of Quotes, even though it returns definitely just one single random Quote !!!
    func fetchQuotes() async throws -> [Quote] {
        
        guard let url = URL(string: "https://zenquotes.io/api/today") else {
            throw HTTPError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let outputQuotes = try JSONDecoder().decode([Quote].self, from: data)
        return outputQuotes
        
// The cashing to SwiftData happens in the View, unlike the Tutorial ;-D
        // caching in SwiftData:
      //  outputQuotes.forEach { quoteModelContext.insert($0) }
        
        // saving current date in AppStorage for future comaprisons with new daily quote
      //  lastFetchedDate = getCurrentDate()
    }
     
}

