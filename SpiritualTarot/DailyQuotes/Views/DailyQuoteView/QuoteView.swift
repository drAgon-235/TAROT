//
//  QuoteView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    
    //@StateObject private var quotesVM = QuotesViewModel()
    //@StateObject private var favQuotesVW = FavoriteQuotesVM()
    @StateObject private var userVM = UserViewModel()

    @State var showFavConfirmAlert = false
    
    var body: some View {
        NavigationStack{
            VStack {
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
            }
                     
                VStack {
                        APIQuoteView()
                        // implementing the cache container: (gets FORGOTTEN very OFTEN !!!)
                        .modelContainer(for: [Quote.self])
                }
                                
                Spacer()
            }

            //.onAppear(){
              // quotesVM.fetchData() // not neccessary, if init(fetchData())-Block in VM
            //}
        }
    }


#Preview {
    QuoteView()
}

