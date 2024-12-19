
import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth

class LogInViewModel: ObservableObject {
    init() {
        checkLogin()
    }
    @Published var isRegistered: Bool = false
    @Published private(set) var user: FirestoreUser?
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var signInError: String?
    @Published var registrationError: String?
    
    private let auth = Auth.auth()
    
    var username: String? {
        user?.username
    }
    
    var isAnonym: Bool {
        auth.currentUser?.isAnonymous ?? true
    }
    var isLoggedIn: Bool {
        self.user != nil
    }
    
    func signIn(email: String, password: String) {
        emailError = nil
        passwordError = nil
        signInError = nil

        guard isValidEmail(email) else {
            emailError = "Please enter a valid Email-Adress."
            return
        }

        guard password.count >= 6 else {
            passwordError = "The Password must be at least 6 characters long."
            return
        }

        auth.signIn(withEmail: email, password: password) { result, error in
            if let error {
                self.signInError = "Log In failed - Please check your Email-Adress and Password - : \(error.localizedDescription)"
                return
            }
            guard let result else { return }
            self.fetchFirebaseUser(id: result.user.uid)
        }
    }
    
    func signInAnonymously() {
        auth.signInAnonymously { result, error in
            if let error {
                print("Error: \(error)")
                return
            }
            guard let result else { return }
            self.firebaseUserSigning(id: result.user.uid, username: "anonymous", email: "", password: "")
            self.fetchFirebaseUser(id: result.user.uid)
            self.isRegistered = true
        }
    }
    
    func register(username: String, email: String, password: String, passwordConfirm: String) {
        emailError = nil
        passwordError = nil
        registrationError = nil

        guard username.count >= 3 else {
            registrationError = "The user name must contain at least 3 characters."
            return
        }

        guard isValidEmail(email) else {
            emailError = "Please enter a valid e-mail address."
            return
        }

        guard password == passwordConfirm && password.count >= 6 else {
            passwordError = "Passwords do not match or too short (at least 6 characters)."
            return
        }

        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.registrationError = "Sign up failed: \(error.localizedDescription)"
                return
            }
            guard let result else { return }
            let userId = result.user.uid
            self.firebaseUserSigning(id: userId, username: username, email: email, password: password)
            self.fetchFirebaseUser(id: userId)
            self.isRegistered = true
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
    
    func checkLogin() {
        if let user = auth.currentUser {
            fetchFirebaseUser(id: user.uid)
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }

    func firebaseUserSigning(id: String, username: String, email: String, password: String) {
        let firebaseUser = FirestoreUser(id: id, username: username, email: email, password: password)
        do {
            try FirebaseManager.shared.database.collection("users").document(id).setData(from: firebaseUser)
        } catch {
            print("Saving user to Firestore failed: \(error)")
        }
    }

    func fetchFirebaseUser(id: String) {
        FirebaseManager.shared.database.collection("users").document(id).getDocument { user, error in
            if let error {
                print("Error fetching user from Firestore: \(error)")
                return
            }
            guard let user else { return }
            do {
                let fireUser = try user.data(as: FirestoreUser.self)
                self.user = fireUser
            } catch {
                print("Error parsing Firestore user data: \(error)")
            }
        }
    }
}

