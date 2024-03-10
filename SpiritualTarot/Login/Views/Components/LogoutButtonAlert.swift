//
//  LogoutButtonAlert.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct LogoutButtonAlert: View {
    
    @EnvironmentObject private var userVM: UserViewModel
    @StateObject private var favoriteQuotesVM = FavoriteQuotesVM()
    @StateObject private var savedSessionsVM = SavedSessionViewModel()
    
    @State private var alertVisible = false
    var color: Color

    var body: some View {
        VStack {
            Button {
                alertVisible.toggle()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(color)
            }
        }
        .alert("Logout?", isPresented: $alertVisible) {
            Button("OK") {
                userVM.logout()
                // Very Important after each Logout:
                favoriteQuotesVM.removeListener() // ! ! !
                savedSessionsVM.removeListener()  // ! ! !

            }
            Button("Cancel", role: .cancel) {}
        }   
    }
}

#Preview {
    LogoutButtonAlert(color: Color.white)
}
