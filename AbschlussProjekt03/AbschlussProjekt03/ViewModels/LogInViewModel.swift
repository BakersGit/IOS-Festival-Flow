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
    
    private let auth = Auth.auth()
    
    var isAnonym: Bool {
        auth.currentUser?.anonymous() ?? true
    }
    var isLoggedIn: Bool {
        self.user != nil
    }
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error {
                print("Error: \(error)")
                return
            }
            guard let result else { return }
            print("Signed in as: \(result.user)")
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
            print("Successfully signed anonymously: \(result.user)")
            self.isRegistered = true
        }
    }
    func register(username: String, email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error?.localizedDescription {
                print("Error: \(error.description)")
                return
            }
            guard let result else { return }
            print("User - \(result.user) - successfully created")
            
            self.firebaseUserSigning(id: result.user.uid, username: username, email: email, password: password)
            self.fetchFirebaseUser(id: result.user.uid)
            self.isRegistered = true
        }
    }
    func signOut() {
        do {
            try auth.signOut()
            self.user = nil
            print("Signed out")
        } catch {
            print("Error: \(error)")
        }
    }
    func checkLogin() {
        if let user = self.auth.currentUser {
            print("User allready logged In: \(user.uid)")
            self.fetchFirebaseUser(id: user.uid)
        }
    }
    
    func firebaseUserSigning (id: String, username: String, email: String, password: String) {
        let firebaseUser = FirestoreUser(id: id, username: username, email: email, password: password)
        do {
            try FirebaseManager.shared.database.collection("users").document(id).setData(from: firebaseUser)
        } catch {
            print("Saving user to Firestore failed \(error)")
        }
    }
    func fetchFirebaseUser(id: String) {
        FirebaseManager.shared.database.collection("users").document(id).getDocument { (user, error) in
            if let error {
                print("Error fetching user from Firestore: \(error)")
                return
            }
            guard let user else { return }
            do{
                let fireUser = try user.data(as: FirestoreUser.self)
                self.user = fireUser
            } catch {
                print("User does not exist \(error)")
            }
        }
    }
}
