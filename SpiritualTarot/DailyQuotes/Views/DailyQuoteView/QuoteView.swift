//
//  QuoteView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct QuoteView: View {
    
    @ObservedObject private var cashVM = CashedQuoteVM()
    @StateObject private var quotesVM = QuotesViewModel()
    @StateObject private var favQuotesVW = FavoriteQuotesVM()
    @StateObject private var userVM = UserViewModel()

    @State var showFavConfirmAlert = false
    
    func generateCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy" // MMM: short month name
        return formatter.string(from: Date())
    }
    
    func putToDailyCashe() {
        Task {
            do {
                try await cashVM.putToDailyCashe(quote: CashedQuote(q: quotesVM.quote.first!.q,
                                                              a: quotesVM.quote.first!.a,
                                                              date: generateCurrentDate()))
            } catch {
                
            }
        }
        
    }
    
    
/*
    func generateQuote() -> String {
        var quote = ""
        var author = ""

        // here the cashing happens: if the quote in the cashe has the same date as today,
        // then the quote from the cash is loaded - no API call neccessary!
        if cashVM.cashedQuoteToday.date == generateCurrentDate() {
             quote = cashVM.cashedQuoteToday.q
            author = cashVM.cashedQuoteToday.a

        } else {
        // if the cashe-date is another than today, we start an API call and save the data with current date to cashe:
             quote = quotesVM.quote.first?.q ?? "API ERROR 404 - Quote"
            //here the new quote is saved in the cashe for 24 hours:
            cashVM.cashedQuoteToday.q = quote
            author = quotesVM.quote.first?.a ?? "API ERROR 404 - Author"
            //here the new author is saved in the cashe for 24 hours:
            cashVM.cashedQuoteToday.a = author
            // and the current date is also saved to cashe:
            cashVM.cashedQuoteToday.date = generateCurrentDate()
        }
        return quote
    }
 */
    
 
 /*
    // same story with the author:
    func generateAuthor() -> String {
        var author = ""
        if cashVM.cashedQuoteToday.date == generateCurrentDate(){
            author = cashVM.cashedQuoteToday.a
        } else {
            author = quotesVM.quote.first?.a ?? "API ERROR 404 - Author"
            //here the new author is saved in the cashe for 24 hours:
            cashVM.cashedQuoteToday.a = author
        }
        return author
    }
  */
    
    
    var body: some View {
        NavigationStack{
            let quote = quotesVM.quote.first?.q ?? "API ERROR 404 - Quote"

            VStack {
                // Filling the variable with data from the VM, triggering an API call by init() of the VM
                VStack{
                    HStack{
                        Image(systemName: "quote.opening")
                        Text("Quote of the day")
                        Image(systemName: "quote.closing")
                    }
                    .padding(.top, 10)
                    
                    Text("for: ")
                        .font(.title3)
                    
                    Text(userVM.name)
                        .bold()
                        .padding(2)
                        .font(.title2)
                        .foregroundColor(.purple)
                }
                .foregroundColor(.mint)
                    
                DateTodayView()
                    .padding(.top, 25)
                
                Spacer()

                HStack{
                        Spacer()
                        // checking, if the quote already is in Favorites DB:
                    if favQuotesVW.containsQuote(quote) {
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
                    
                VStack {
                    //doesn't really work properly
                    if generateCurrentDate() == cashVM.cashedQuoteToday.first!.date {
                        CasheQuoteView()
                        Text("CASHE") // For TEst

                    }else {
                        APIQuoteView()
                        Text("API Call") // For TEst
                    }
                }
                                
                Spacer()
            }
            .alert("Save to favorites list?", isPresented: $showFavConfirmAlert) {
                Button("OK"){
                    favQuotesVW.createFavQuote(thisQuote: quotesVM.quote.first!.q, thisAuthor: quotesVM.quote.first!.a, thisFavorite: true)
                }
                Button("Cancel", role: .cancel) {}
            }
            //.onAppear(){
              // quotesVM.fetchData() // not neccessary, if init(fetchData())-Block in VM
            //}
        }
    }
}

#Preview {
    QuoteView()
}


/*
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
 
 */
