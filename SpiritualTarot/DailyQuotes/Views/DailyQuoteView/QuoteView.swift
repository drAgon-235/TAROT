//
//  QuoteView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct QuoteView: View {
    
    @StateObject private var cashVM = CashedQuoteVM()
    @StateObject private var quotesVM = QuotesViewModel()
    @StateObject private var favQuotesVW = FavoriteQuotesVM()
    @StateObject private var userVM = UserViewModel()

    @State var showFavConfirmAlert = false

    var body: some View {
        NavigationStack{
            VStack {
                // Filling the variable with data from the VM, triggering an API call by init() of the VM
                let quote = quotesVM.quote.first?.q ?? "API ERROR 404 - Quote"
                let author = quotesVM.quote.first?.a ?? "API ERROR 404 - Author"
                
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
