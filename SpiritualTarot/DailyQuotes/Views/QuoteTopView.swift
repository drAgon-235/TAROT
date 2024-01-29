//
//  QuoteTopView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct QuoteTopView: View {
        
    @StateObject private var cashVM = CashedQuoteVM()
    @StateObject private var quotesVM = QuotesViewModel()

    // manage the changing to other Views with toggles
    @State var showQuoteView = false
    
    func generateCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy" // MMM: short month name
        return formatter.string(from: Date())
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                Button(action: {
                    // this works properly, tested !:
                    // if the current date is the same as the date of the cash-element, nothing happens (cash stays untouched)
                    if generateCurrentDate() == cashVM.cashedQuoteToday.first!.date {
                       print("Button pressed: No Action")
                        // this obviously works, but on appearing of the Quote View, cash is being reset to default , why?

                    // else: the Cash is being updated with fresh API-call-data, if the current date is different than the date of the cash-element
                    }else {
                        let quote = quotesVM.quote.first?.q ?? "API ERROR 404 - Quote"
                        let author = quotesVM.quote.first?.a ?? "API ERROR 404 - Author"
                        cashVM.putToDailyCashe(quote: CashedQuote(q: quote, a: author, date: generateCurrentDate()))
                        print("Button pressed: Saving to cash successful")

                    }
                    
                    showQuoteView.toggle()}, label: {
                    HStack(spacing: 10) {
                        Image(systemName: "quote.bubble")
                        Text("Quote of the day")
                    }
                    .frame(minWidth: 0)
                    .font(.title)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .foregroundColor(.white)
                    .background(Color.mint)
                    .cornerRadius(10)
                })
                .padding(40)
                
                
                // Just for testing: What is in the cash ?e:
                NavigationLink(destination: CasheQuoteView()) {
                    Text("Cashe Test")
                }
                
                
                
                NavigationLink(destination: FavoriteQuotesView()) {
                    ShowFavBTN()
                }
                .navigationBarTitle(Text("Daily quotes"))
                .toolbar {
                    HStack {
                        Spacer()
                        LogoutButtonAlert()
                    }
                }
                /*
                .onTapGesture {
                    
                        //doesn't really work properly
                        if generateCurrentDate() == cashVM.cashedQuoteToday.date {
                           
                            //Text("CASHE") // For TEst

                        }else {
                            let quote = quotesVM.quote.first?.q ?? "API ERROR 404 - Quote"
                            let author = quotesVM.quote.first?.a ?? "API ERROR 404 - Author"
                            cashVM.putToDailyCashe(quote: Quote(q: quote, a: author))
                            //Text("API Call") // For TEst
                        }
                    }
                */
                
            }
        }
        // sheet for Quote of the Day
        .sheet( isPresented: $showQuoteView){
            QuoteView()
            Button("Close"){ showQuoteView.toggle() }
            Spacer()
        }
    }
}

#Preview {
    QuoteTopView()
}
