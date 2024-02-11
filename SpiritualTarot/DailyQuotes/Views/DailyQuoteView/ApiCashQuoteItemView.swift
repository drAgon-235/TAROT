//
//  QuoteFromAPI.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 27.01.24.
//

import SwiftUI
import SwiftData

struct ApiCashQuoteItemView: View {
    
    // Variables for saving Favorite Quotes in Firebase:
    @StateObject private var favQuotesVW = FavoriteQuotesVM()
    @State var showFavConfirmAlert = false
    
    // Variables for Caching the daily Quote - only one API call per day neccessary !!!:
    @Environment(\.modelContext) private var quoteModelContext
    @AppStorage("lastFetched") private var lastFetchedDate: String = "Start"
    @Query() private var allDaQuotes: [Quote]

    // showing animation while loading the Daily Quoe from API - almost invisible :-D
    @State private var isLoading = false
    
    // for Testing purposes:
    @State private var cachingTest: String = "Cashe !!!"

    // checks if Quote is already in Favourites list:
    // (most tricky part of this View - took me 2 days to figure out, this has to be an extra function also checking EMPITNESS first)
    func favQuoteExists() -> Bool {
        if allDaQuotes.isEmpty  {
            return false // this check prevents crashes if 'allDaQuotes == nil', which regularly happened on first usage !!!
        } else if favQuotesVW.containsQuote(allDaQuotes.first!.q)  {
            return true
        } else {
            return false
        }
    }
    
    
    var body: some View {
        VStack {
            HStack{
                    Spacer()
                    // checking, if the quote already is in Favorites DB:
                if favQuoteExists()  {
                        Text("Is saved in your")
                            .foregroundColor(.purple)
                       
                        NavigationLink(destination: FavoriteQuotesView()) {
                            ShowFavListBTN()
                        }
                        
                        Image(systemName: "heart.fill")
                            .padding(.trailing, 30)
                            .foregroundColor(.purple)
                } else {
                        AddToFavoritesBTN(action: {showFavConfirmAlert.toggle()})
                            .padding(.trailing, 30)
                }
            }
            
                // We only take Data from Cashe here: the Task.onAppear below decides whether it is old data or it is being freshly filled with API data before
                ForEach(allDaQuotes) { quote in
                    VStack {
                        Text(quote.q)
                            .font(.title2)
                            .foregroundColor(.white)
                        Divider()
                        Text(quote.a)
                            .padding(4)
                            .foregroundColor(.purple)
                        
                    }
                    .padding()
                    .background(Color.mint)
                    .cornerRadius(10)
                    .padding()
                }
           
            // Test Fields:
            Text("Status: \(cachingTest)")
            Text("Last Data: \(lastFetchedDate)")
           // Text(allDaQuotes.first!.q)
            
            Spacer()
        }
        .onAppear {
            if !lastSavedDayIsSameAsToday() || allDaQuotes.isEmpty{
            Task {
                do {
                    isLoading = true
                    defer { isLoading = false }
                        clearDailyQuoteCache()
                        try await fetchQuotes()  // Our cashe: 'allDataQuotes' gets refreshed with API request
                        cachingTest = "API Call !!!"
                } catch {
                    print("Error in fetchQuotes \(error)")
                }
            }
            } // else: data cached in 'allDataQuotes' is called

        }
        /*
        .task {
            do {
                isLoading = true
                defer { isLoading = false }
                if !lastSavedDayIsSameAsToday() || allDaQuotes.isEmpty || lastFetchedDate == "Start" {
                    clearDailyQuoteCache()
                    try await fetchQuotes()  // Our cashe: 'allDataQuotes' gets refreshed with API request
                    cachingTest = "API Call !!!"
                } // else: data cached in 'allDataQuotes' is called
                
            } catch {
                print("Error in fetchQuotes \(error)")
            }
        }
        */
        // almost invisible:
        .overlay {
            if isLoading {
                ProgressView()
            }
        }
        
        .alert("Save to favorites list?", isPresented: $showFavConfirmAlert) {
            Button("OK"){
                favQuotesVW.createFavQuote(thisQuote: allDaQuotes.first!.q, thisAuthor: allDaQuotes.first!.a, thisFavorite: true)
            }
            Button("Cancel", role: .cancel) {}
        }
        
    }
}

#Preview {
    ApiCashQuoteItemView()
        .modelContainer(for: [Quote.self])

}


// Extension for caching in SwiftData & AppStorage:
extension ApiCashQuoteItemView {
    
    // The tricky part is, that the JSON call gives a List[Quote] of Quotes, even if it is definitely just one single random Quote !!!
    func fetchQuotes() async throws {
        
        guard let url = URL(string: "https://zenquotes.io/api/today") else {
            throw HTTPError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let outputQuotes = try JSONDecoder().decode([Quote].self, from: data)
        
        outputQuotes.forEach { quoteModelContext.insert($0) }
        
        lastFetchedDate = getCurrentDate()
    }
    
    
    func lastSavedDayIsSameAsToday() -> Bool {
        let dateToday = getCurrentDate()
        let lastCall = lastFetchedDate
        //var retValue = false
        
        if dateToday == lastCall {
            return true
        } else {
            return false
        }
    }
    
    // in case of loading new Quote from API & loading it to cash
    // the old Quote cash data is being deleted:
    func clearDailyQuoteCache() {
        _ = try? quoteModelContext.delete(model: Quote.self)
    }
    
    // gives us the current date formatted to a String:
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy" // MMM: short month name
        return formatter.string(from: Date())
    }
}

