//
//  LogoutButtonAlert.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI

struct LogoutButtonAlert: View {
    
    @EnvironmentObject private var userVM: UserViewModel
    @State private var alertVisible = false

    var body: some View {
        VStack {
            Button {
                alertVisible.toggle()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
            }
        }
        .alert("Logout?", isPresented: $alertVisible) {
            Button("OK") {
                userVM.logout()
                //marketVM.removeListener()  // important for DB !!!
            }
            Button("Cancel", role: .cancel) {}
        }    }
}

#Preview {
    LogoutButtonAlert()
}
