import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct Checklist: Codable, Identifiable {
    @DocumentID var id: String?
    var userId: String
    var title: String
    var items: [Item]
    
}

struct Item: Codable, Identifiable, Equatable {
    var id: String?
    var name: String
    var quantity: Int
}

