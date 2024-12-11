import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    let auth = Auth.auth()
    let database = Firestore.firestore()
    
    @Published var user: FirestoreUser?
    
    var userId: String? {
        auth.currentUser?.uid
    }
    
    private init() {}

    func createUser(with id: String, username: String, email: String, password: String) {
        let user = FirestoreUser(id: id, username: username, email: email, password: password)
        
        do {
            try database.collection("users").document(id).setData(from: user)
            self.fetchUser(with: id)
        } catch {
            print("Saving user failed: \(error)")
        }
    }
    
    private func fetchUser(with id: String) {
        FirebaseManager.shared.database.collection("users").document(id).getDocument { document, error in
            if let error {
                print(error)
                return
            }
            
            guard let document else { return }
            
            do {
                let user = try document.data(as: FirestoreUser.self)
                self.user = user
            } catch {
                print("Dokument ist kein User")
            }
        }
    }

}
