
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct FirestoreUser: Codable, Identifiable {
    
    var id: String?
    var username: String
    var email: String
    var password: String
    var favoriteEvents: [String] = []    
}
