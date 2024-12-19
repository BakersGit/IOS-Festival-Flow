import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct Checklist: Codable, Identifiable {
    @DocumentID var id: String?
    var userId: String
    var title: String
    var items: [Item]
    var sharedWith: [String] = []    
}

struct Item: Codable, Identifiable, Equatable {
    var id: String?
    var name: String
    var quantity: String
    var isCompleted: Bool = false
    var category: ItemCategory
}
enum ItemCategory: String, Codable, CaseIterable, Identifiable {
    case hygiene = "Hygiene Items"
    case clothing = "Clothing"
    case equipment = "Equipment"
    case firstAid = "First Aid"
    case documents = "Documents"
    case food = "Food"
    case others = "Others"

    var id: String { self.rawValue }
}
