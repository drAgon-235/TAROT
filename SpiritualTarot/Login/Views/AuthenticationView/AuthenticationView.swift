//
//  AuthenticationView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI
import Firebase

struct AuthenticationView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject private var userViewModel: UserViewModel
    
    @State private var mode: AuthenticationMode = .login
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""

    
    
    
    // MARK: - Computed Properties
    // Disable the Primary Button, if one of the input fields is empty :
    private var disableAuthentication: Bool {
        email.isEmpty || password.isEmpty
    }
    
    
    
    // MARK: - Functions
    
    // For the text under the Button, and the button's own text:
    private func switchAuthenticationMode() {
        mode = mode == .login ? .register : .login
    }
    
    // Central Function:
    private func authenticate() {
        switch mode {
        case .login:
            userViewModel.login(email: email, password: password)
        case .register:
            userViewModel.register(email: email, name: name, password: password)
        }
    }
    
    
    var body: some View {
        VStack(spacing: 49) {
            Image("")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            
            VStack(spacing: 12) {
                // The visibility of the Field depends on the Enum (AuthenticationMode) and it's state:
                if mode.nameFieldIsVisible {
                    ZStack(alignment: .bottom) {
                        TextField("Name", text: $name)
                            .padding(5)
                            .foregroundColor(Color.black)
                               .accentColor(Color.purple)
                            .frame(minHeight: 36)
                            .background(.white.opacity(0.9))
                        Divider()
                    }
                    .cornerRadius(5)
                }
                
                
                ZStack(alignment: .bottom) {
                    TextField("E-Mail", text: $email)
                        .padding(5)
                        .foregroundColor(Color.black)
                           .accentColor(Color.mint)
                        .frame(minHeight: 36)
                        .background(.white.opacity(0.9))

                    Divider()
                }
                .cornerRadius(5)
                
                ZStack(alignment: .bottom) {
                    SecureField("Passwort", text: $password)
                        .padding(5)
                        .foregroundColor(Color.black)
                           .accentColor(Color.mint)
                        .frame(minHeight: 36)
                        .background(.white.opacity(0.9))
                    
                    Divider()
                }
                .cornerRadius(5)
                
            }
            .font(.headline)
            .textInputAutocapitalization(.never)
            
            PrimaryButton(title: mode.title, action: authenticate)
            // Make the BTN disabled, if one input field is empty:
                .disabled(disableAuthentication)
            
            TextButton(title: mode.alternativeTitle, action: switchAuthenticationMode)
        }
        .padding(30)
        .background(Image("aaastar04").resizable().scaledToFill().opacity(0.7))
        
    }
}

#Preview {
    AuthenticationView()
}
