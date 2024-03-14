//
//  AuthenticationView.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import SwiftUI
import Firebase

struct AuthenticationView: View {
    
    // Variables:
    @EnvironmentObject private var userViewModel: UserViewModel
    
    @State private var mode: AuthenticationMode = .login
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""

    //      Work-around for failed Logins:
    // For showing the Alert and/or loginAnimation:
    @State private var loginFailed = false
    @State private var sleepAnimation = false

    // Computed Properties:
    // Disable the Primary Button, if one of the input fields is empty :
    private var disableAuthentication: Bool {
        email.isEmpty || password.isEmpty
    }
    
    // Self Made: (for the wrong-input-workaround)
    private func paswordIsCorrect() -> Bool {
        if userViewModel.userIsLoggedIn {
            return true
        } else {
           return false
        }
    }
    
    // Functions:
    // For the text under the Button, and the button's own text:
    private func switchAuthenticationMode() {
        mode = mode == .login ? .register : .login
    }
    
    // Central Function :
    // (extended by myself for wrong-data-input-workaround - took me 2 days to find this solution)
    private func authenticate() async throws {
        switch mode {
        case .login:
            // Should happen as a Task:
           userViewModel.login(email: email, password: password)
        case .register:
            userViewModel.register(email: email, name: name, password: password)
        }        
    }
    
    // Functions for LoginAnimation:
    @State var thisDegree = 0.0
    @State var isTurned: Bool = false
    
    func turnWheel() {
            isTurned.toggle()
            if isTurned {
                withAnimation(.bouncy.delay(0.2)) {
                    thisDegree = 360
                }
            } else {
                withAnimation(.bouncy.delay(0.2)) {
                    thisDegree = 0
                }
            }
        }
    
    
    var body: some View {
        ZStack {
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
                
                PrimaryButton(title: mode.title, action: {
                    // start login animation:
                    sleepAnimation = true
                    turnWheel()
                    Task() {
                        try await self.authenticate()
                    
                        // solves the issue with shortly appearing the alert(Login FAILED) though Login was successful:
                        try? await Task.sleep(nanoseconds: 1_500_000_000)
                        
                        // stop login animation:
                        sleepAnimation = false
                        
                        // then, as 2nd step: show LOGIN.Alert (or not):
                        if userViewModel.loginFailed {
                            loginFailed = true
                        } else {
                        }
                    }
                })
                // Make the BTN disabled, if one input field is empty:
                .disabled(disableAuthentication)
                
                // The changeable Mode Button:
                TextButton(title: mode.alternativeTitle, action: switchAuthenticationMode)
            }
            .padding(30)
            .background(Image("aaastar04").resizable().scaledToFill().opacity(0.7))
            
            //      Work-around
            // In case of wrong-data-input:
            .alert("Login FAILED", isPresented: $loginFailed) {
                Button("Try again", role: .cancel) {
                    // setting back the input data:
                    loginFailed = false;
                    self.password = "";
                    self.email = "";
                    userViewModel.loginFailed = false
                }
            }
            
            // The Login Animation before alert or Login:
            if sleepAnimation {
                LoginAnimation(myDegree: $thisDegree)
            } else {
                
            }
        }

    }
}

#Preview {
    AuthenticationView()
}
