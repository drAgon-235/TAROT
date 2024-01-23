//
//  SpiritualTarotApp.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI
import Firebase

@main
struct SpiritualTarotApp: App {
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    @StateObject private var userVM = UserViewModel()

    var body: some Scene {
        WindowGroup {
            if userVM.userIsLoggedIn {
                NavigatorView()
                    .environmentObject(userVM)
            } else {
                AuthenticationView()
                    .environmentObject(userVM)
            }
        }
    }
}
