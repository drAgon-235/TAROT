//
//  QuoteFromAPI.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 27.01.24.
//

import SwiftUI
import SwiftData

// Arguments for breaking the MVVM in this case:
// 1. the fetched Data (from Api or SwiftData) is only used in this View
// 2. the SwiftData actually IS the View Model !!! used here

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
    // (most tricky part of this View - took me 2 days to figure out, this has to be an extra function also checking EMPTYNESS first)
    func favQuoteExists() -> Bool {
        // this order is necessary:
        if allDaQuotes.isEmpty  {
            // this check prevents crashes if 'allDaQuotes == nil', which regularly happened on first usage !!!
            return false
        } else if favQuotesVW.containsQuote(allDaQuotes.first!.q)  {
            return true
        } else {
            return false
        }
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack{
                    Spacer()
                    // checking, if the quote already is in Favorites DB:
            //  if favQuotesVW.containsQuote(allDaQuotes.first!.q) {  <-this didn't work at all
                //(it took me 2 day to fix it with: func favQuoteExists()  above)
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
                    .shadow(radius: 10)
                }
           
            // Test Fields:
            Text("Status: \(cachingTest)")
        //    Text("Last Data: \(lastFetchedDate)")
           // Text(allDaQuotes.first!.q)
            
            Spacer()
        }
        .onAppear {
            if !lastSavedDayIsSameAsToday() || allDaQuotes.isEmpty{
            Task {
                do {
                    // almost invisible loading animation:
                    isLoading = true
                    defer { isLoading = false }
                    // cler cashe before refilling:
                        clearDailyQuoteCache()
                    // get quote from API:
                        try await fetchQuotes()  // Our cashe: 'allDataQuotes' gets refreshed with API request
                        cachingTest = "API Call !!!"
                } catch {
                    print("Error in fetchQuotes \(error)")
                }
            }
            } // else: data cached in 'allDataQuotes' is called

        }
        /*
         // alternative Code to .onAppear:
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
        
        // confirm saving to favorites list:
        .alert("Save to favorites list?", isPresented: $showFavConfirmAlert) {
            Button("OK"){
                // saving to favorites List in Firestore:
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
    
    // The tricky part is, that the JSON call gives a List[Quote] of Quotes, even though it returns definitely just one single random Quote !!!
    func fetchQuotes() async throws {
        
        guard let url = URL(string: "https://zenquotes.io/api/today") else {
            throw HTTPError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let outputQuotes = try JSONDecoder().decode([Quote].self, from: data)
        
        // caching in SwiftData:
        outputQuotes.forEach { quoteModelContext.insert($0) }
        
        // saving current date in AppStorage for future comaprisons with new daily quote
        lastFetchedDate = getCurrentDate()
    }
    
    // Checking if cashed date (lastFetchedDate) is same as today:
    func lastSavedDayIsSameAsToday() -> Bool {
        let dateToday = getCurrentDate()
        let lastCall = lastFetchedDate
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

