//
//  TarotTopView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct TarotTopView: View {
    var body: some View {
        NavigationStack {
            Repo_TestView()
            //Text("TAROT Top View")
                .toolbar {
                    HStack {
                        Spacer()
                        LogoutButtonAlert()
                    }
                }
        }
    }
}

#Preview {
    TarotTopView()
}
