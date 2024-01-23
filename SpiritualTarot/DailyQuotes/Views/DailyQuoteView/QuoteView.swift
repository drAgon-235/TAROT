//
//  QuoteView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct QuoteView: View {
    
    @StateObject private var quotesVM = QuotesViewModel()

    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    Image(systemName: "quote.opening")
                    Text("Quote of the day")
                    Image(systemName: "quote.closing")
                }
                .padding()
                
                Spacer()
                    HStack{
                        Spacer()
                        AddToFavoritesBTN(action: {})
                            .padding(.trailing, 30)
                    }
                    
                    VStack {
                        Text(quotesVM.quote.first?.q ?? "API ERROR 404 - Quote")
                            .font(.title2)
                        
                        Divider()
                        
                        Text(quotesVM.quote.first?.a ?? "API ERROR 404 - Author")
                            .padding(4)
                    }
                    .padding()
                    .background(Color.teal)
                    .cornerRadius(10)
                    .padding()
                Spacer()
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
