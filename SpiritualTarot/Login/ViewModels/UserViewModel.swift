//
//  UserViewModel.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 23.01.24.
//

import Foundation
import Firebase

class UserViewModel: ObservableObject {
    
    init() {
        checkAuth()
    }
    
    
    // MARK: - Variables
    
    // ? ! ? ! ?
    //private var auth = Auth.auth()
    
    @Published var user: FireUser?
    
    //Firebase Variablen:
    private let firebaseManager = FirebaseManager.shared

    
    
    
    // MARK: - Computed Properties
    
    var userIsLoggedIn: Bool {
        firebaseManager.auth.currentUser != nil
        //user != nil
    }
    
    var email: String {
        user?.email ?? "Email"
    }
    
    var name: String {
        user?.name ?? "Name"
    }
    
    // MARK: - Functions
    
    /**
     Überprüfen, ob aktuell ein User angemeldet ist. Falls ja, wird der User gesetzt.
     
     Sollte bei jedem App-Start ausgeführt werden.
     */
    private func checkAuth() {
        guard let currentUser = firebaseManager.auth.currentUser else {
            print("Not logged in")
            return
        }
        
        self.fetchUser(with: currentUser.uid)
    }
    
    /**
     Zum Login nehmen wir E-Mail und Passwort. Falls kein Error entsteht, setzen wir den neu angemeldeten User.
     */
    func login(email: String, password: String) {
        firebaseManager.auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Login failed:", error.localizedDescription)
                return
            }
            
            guard let authResult, let email = authResult.user.email else { return }
            print("User with email '\(email)' is logged in with id '\(authResult.user.uid)'")
            
            self.fetchUser(with: authResult.user.uid)
        }
    }
    
    /**
     Bei der Registrierung übergeben wir E-Mail und Passwort. Falls kein Error entsteht, führen wir nach der Registrierung einen Login durch (das passiert nicht automatisch).
     
     Normalerweise würden wir an dieser Stelle auch ein User-Objekt in unserem Firestore erstellen. Das kommt in der nächsten Vorlesung.
     */
    func register(email: String, name: String, password: String) {
        firebaseManager.auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Registration failed:", error.localizedDescription)
                return
            }
            
            guard let authResult, let email = authResult.user.email else { return }
            print("User with email '\(email)' is registered with id '\(authResult.user.uid)'")
            
        // Hier wird ein FireUser erstellt und in die Datenbank gesteckt:
            //Und zwar ohne Passwort !!! DSGVO !!! ???
            self.createUser(with: authResult.user.uid, name: name, email: email)
            
            // Nach der Registrierung möchten wir unseren User auch direkt anmelden.
            // Dazu können wir einfach die login()-Funktion aufrufen und E-Mail und Passwort weitergeben
            self.login(email: email, password: password)
        }
    }
    
    /**
     Der Logout entfernt den aktuellen User und wir setzen unsere User-Variable ebenfalls nil.
     */
    func logout() {
        do {
            try firebaseManager.auth.signOut()
            self.user = nil
            
            print("User wurde abgemeldet!")
        } catch {
            print("Error signing out: ", error.localizedDescription)
        }
    }
    
    

    func deleteAccount() async throws {
        do {
            //try await firebaseManager.database.collection("users").document(user!.name).delete()
            try await firebaseManager.auth.currentUser?.delete()
            self.user = nil

            print("User wurde gelöscht!")
        } catch {
            print("Error deleting Account in UserViewModel: ", error.localizedDescription)
        }
    }

    
}



// MARK: Data

extension UserViewModel {
    
    /**
     Erstellen eines User-Dokuments im Firestore.
     
     Als 'registeredAt' setzen wir das Datum für den Moment, in dem die Registrierung statt findet.
     
     In der Collection 'users' wird unter der jeweiligen ID des Users ein Dokument erstellt. Dazu kann das Objekt übergeben werden.
     */
    private func createUser(with id: String, name: String, email: String) {
        let user = FireUser(id: id, name: name, email: email, registeredAt: Date())
        
        do {
            try firebaseManager.database.collection("users").document(id).setData(from: user)
        } catch let error {
            print("Fehler beim Speichern des Users: \(error)")
        }
    }
    
    /**
     Der User wird mit der ID geladen, die der auf dem Gerät angemeldete User hat.
     
     Das Dokument, das geladen wird, wird zu einem 'FireUser' und 'user' wird angeschließend gesetzt.
     
     Hinweis: Hier gibt es noch keinen Listener, d.h. es findet kein Echtzeit-Sync statt, das kommt in der nächsten Vorlesung (Teil 4).
     */
    private func fetchUser(with id: String) {
        firebaseManager.database.collection("users").document(id).getDocument { document, error in
            if let error {
                print("Fetching user failed:", error.localizedDescription)
                return
            }
            
            guard let document else {
                print("Dokument existiert nicht!")
                return
            }
            
            do {
                let user = try document.data(as: FireUser.self)
                self.user = user
            } catch {
                print("Dokument ist kein User", error.localizedDescription)
            }
        }
    }
}

