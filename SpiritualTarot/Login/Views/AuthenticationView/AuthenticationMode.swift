//
//  AuthenticationMode.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation

enum AuthenticationMode {
    case login, register
    
    var title: String {
        switch self {
        case .login: return "Login"
        case .register: return "Signing in"
        }
    }
    
    var alternativeTitle: String {
        switch self {
        case .login: return "No Account yet? Sign in!"
        case .register: return "Got an account? Login here"
        }
    }
    
    // Makes the Name-TextField visible in AuthenticationView
    // only while registring, invisible while Logging-in:
    var nameFieldIsVisible: Bool {
        switch self {
        case .login: return false
        case .register: return true
        }
    }
}
