//
//  QuoteFromAPI.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 27.01.24.
//

import SwiftUI
import SwiftData

struct ApiCashQuoteItemView: View {
    
// (it took me 3 days to implement SwiftData into MVVM-Architecture):
    @StateObject private var quoteVM = QuotesViewModel()

// Variables for Caching the daily Quote in SwiftData - only one API call per day neccessary !!!:
    @AppStorage("lastFetched") private var lastFetchedDate: String = "Start"
    @Environment(\.modelContext) private var quoteModelContext
    @Query() private var allDaQuotes: [Quote]

    // showing animation while loading the Daily Quoe from API - almost invisible :-D
    @State private var isLoading = false
    
    // for Testing purposes:
    @State private var cachingTest: String = "Cashe !!!"

// Functions for Caching the daily Quote
    // gives us the current date formatted to a String:
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy" // MMM: short month name
        return formatter.string(from: Date())
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

    
// Variables for saving Favorite Quotes in Firebase:
    @StateObject private var favQuotesVW = FavoriteQuotesVM()
    @State var showFavConfirmAlert = false
    
// Functions for saving Favorite Quotes in Firebase:
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
    
   // var cachingTest = "Using cashing only \nNo API Request!!"
    
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
                            //.foregroundColor(.purple)
                    
                        NavigationLink(destination: AllFQsListView()) {
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
                    }
                    .padding()
                    .background(Color.orange.opacity(0.6))
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 10)
                }
            Text(cachingTest)

            Spacer()
        }
        .onAppear {
            if !lastSavedDayIsSameAsToday() || allDaQuotes.isEmpty{
                // this Task is executed  ONLY ONCE per day (or if allDaQuotes.isEmpty):
            Task {
                do {
                    // almost invisible loading animation:
                    isLoading = true
                    defer { isLoading = false }
                    
                    // clear cashe before refilling:
                    clearDailyQuoteCache()
                    
                    // get quote from API using ViewModel (MVVM):
                    let gotQuote = try await quoteVM.fetchQuotes()
           
                    // caching the API Request in SwiftData:
                    gotQuote.forEach { quoteModelContext.insert($0) }
                    
                    // saving current date in AppStorage for future comaprisons with new daily quote
                    lastFetchedDate = getCurrentDate()

                    // If teh API call is made, it is shown on TestVariable:
                    cachingTest = "API Request & cashing !"
                } catch {
                    print("Error in fetchQuotes \(error)")
                }
            }
        } // else: data cached in 'allDataQuotes' is called directly

            
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


