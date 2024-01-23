//
//  QuotesRepository.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation

class QuotesRepository {
    
    // The tricky part is, tah the JSON call gives a List[Quote] of Quotes, even if it is definitely just one single random Quote !!!
    static func fetchQuotes() async throws -> [Quote] {
        
        guard let url = URL(string: "https://zenquotes.io/api/random") else {
            throw HTTPError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode([Quote].self, from: data)
    }
}
