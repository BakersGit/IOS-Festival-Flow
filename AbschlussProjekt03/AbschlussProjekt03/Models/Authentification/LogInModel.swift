import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

@MainActor
class LogInModel: ObservableObject {
    
    @Published private(set) var user: User?

    var isUserLoggedIn: Bool {
        self.user != nil
    }
    private let auth = Auth.auth()

    func singInAnonymously() {
        auth.signInAnonymously() { authResult, error in
            if let error {
                print("Error: \(error)")
                return
            }
            guard let authResult else { return }
            print("User  logged in: \(authResult.user.uid)")
            self.user = authResult.user
        }
    }
    func register(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Error: \(error)")
                return
            }
            guard let authResult, let email = authResult.user.email else { return }
            print("User registered as: \(authResult.user.uid) by: \(email)")
            self.user = authResult.user
        }
    }
    func signIn(withEmail email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Error: \(error)")
                return
            }
            guard let authResult, let email = authResult.user.email else { return }
            print("User authenticated: \(authResult.user.uid) by: \(email)")
            self.user = authResult.user
        }
    }
    func signOut() {
        do {
            try auth.signOut()
            self.user = nil
        } catch {
            print("Error: \(error)")
        }
    }
}

