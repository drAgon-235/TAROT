//
//  QuoteView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    
    @StateObject private var userVM = UserViewModel()

    @State var showFavConfirmAlert = false
    
    var body: some View {
        NavigationStack{
            VStack {
                VStack {
                    VStack{
                        HStack{
                            Image(systemName: "quote.opening")
                            Text("Quote of the day")
                                .font(.title2)
                                .bold()
                            Image(systemName: "quote.closing")
                        }
                        .padding(.top, 10)
                        
                        Text("for: ")
                            //.padding(5)
                            .font(.title2)
                            .bold()
                        
                        Text(userVM.name)
                            .bold()
                            .padding(2)
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                    //.foregroundColor(.orange)
                    
                    DateTodayView()
                        .padding(.top, 25)
                    
                    // Spacer()
                }
                
                VStack {
                    ApiCashQuoteItemView()
                    // implementing the cache container: (gets FORGOTTEN very OFTEN !!!)
                        .modelContainer(for: [Quote.self])
                        //.shadow(radius: 10)

                    
                    ShareLink(item: "TEST 123")
                }
               // .shadow(radius: 10)
                
                Spacer()
            }
            .background {
                LinearGradient(colors: [Color.purple.opacity(0.5), .orange.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        }
    }
}


#Preview {
    QuoteView()
}

