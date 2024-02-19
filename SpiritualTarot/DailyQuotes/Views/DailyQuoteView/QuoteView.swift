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
                    
                    // Spacer()
                }
                
                VStack {
                    ApiCashQuoteItemView()
                    // implementing the cache container: (gets FORGOTTEN very OFTEN !!!)
                        .modelContainer(for: [Quote.self])
                    
                    ShareLink(item: "TEST 123")
                }
                
                Spacer()
            }
            .background(Color.orange.opacity(0.1))

        }
    }
}


#Preview {
    QuoteView()
}

