//
//  ShowFavoritesBTN.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct ShowFavBTN: View {
    var body: some View {
        HStack {
            Image(systemName: "heart.fill")
            Text("Favorite Quotes")
        }
        .font(.title)
        .frame(width: 250, height: 50, alignment: .center)
        .background(Color.blue)
        .foregroundColor(Color.white)
        .cornerRadius(10)    }
}

#Preview {
    ShowFavBTN()
}
