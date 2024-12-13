
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class PreperationViewModel: ObservableObject {
    
    @Published var lists: [Checklist] = []
    @Published var currentItems: [Item] = []
    @Published var errorMessage: String? = nil

  
    // create Checklist
    func createChecklist(title: String, items: [Item]) {
           guard let userId = FirebaseManager.shared.userId else {
               errorMessage = "User ID not found. Cannot create checklist."
               return
           }
           let checklist = Checklist(id: nil, userId: userId, title: title, items: items)
           do {
               try FirebaseManager.shared.database.collection("checklists").addDocument(from: checklist)
               lists.append(checklist)
               currentItems.removeAll()
           } catch {
               errorMessage = "Failed to save checklist. Please try again."
           }
       }
    
    // Fetch Checklists
    func fetchChecklists() {
           guard let userId = FirebaseManager.shared.userId else {
               errorMessage = "User ID not found. Please sign in."
               return
           }
           FirebaseManager.shared.database.collection("checklists")
               .whereField("userId", isEqualTo: userId)
               .addSnapshotListener { querySnapshot, error in
                   if let error = error {
                       self.errorMessage = "Failed to fetch checklists: \(error.localizedDescription)"
                       return
                   }
                   guard let documents = querySnapshot?.documents else {
                       self.errorMessage = "No checklists found. Start by creating one!"
                       return
                   }
                   self.lists = documents.compactMap {
                       do {
                           return try $0.data(as: Checklist.self)
                       } catch {
                           self.errorMessage = "Error decoding checklist data."
                           return nil
                       }
                   }
               }
       }
    // update
    func updateChecklist(with id: String?, title: String) {
            guard let id else {
                errorMessage = "Invalid checklist ID."
                return
            }
            let data = ["title": title]
            FirebaseManager.shared.database.collection("checklists").document(id).updateData(data) { error in
                if let error {
                    self.errorMessage = "Failed to update checklist: \(error.localizedDescription)"
                    return
                }
                self.errorMessage = nil
            }
        }
    
    // add Item to Checklist
    func addItemToChecklist(name: String, quantity: String, category: ItemCategory, checklistId: String) {
           guard !name.isEmpty else {
               errorMessage = "Item name cannot be empty."
               return
           }
           guard let checklistIndex = lists.firstIndex(where: { $0.id == checklistId }) else {
               errorMessage = "Checklist not found."
               return
           }
           let newItem = Item(id: UUID().uuidString, name: name, quantity: quantity, category: category)
           lists[checklistIndex].items.append(newItem)
           let updatedChecklist = lists[checklistIndex]
           do {
               try FirebaseManager.shared.database.collection("checklists")
                   .document(checklistId)
                   .setData(from: updatedChecklist) { error in
                       if let error {
                           self.errorMessage = "Failed to add item to checklist: \(error.localizedDescription)"
                       } else {
                           self.errorMessage = nil
                       }
                   }
           } catch {
               errorMessage = "Failed to update checklist."
           }
       }
    /*
    func addItemToChecklist(name: String, quantity: String, category: ItemCategory, checklistId: String) {
        guard let quantityInt = Int(quantity), !name.isEmpty else {
            print("Invalid input: Name is '\(name)' and Quantity is '\(quantity)'")
            return
        }
        guard let checklistIndex = lists.firstIndex(where: { $0.id == checklistId }) else {
            print("Checklist not found in local data. Checklist ID: \(checklistId)")
            print("Available checklists: \(lists.map { $0.id ?? "nil" })")
            return
        }
        let newItem = Item(id: UUID().uuidString, name: name, quantity: quantityInt, category: category)
        lists[checklistIndex].items.append(newItem)
        let updatedChecklist = lists[checklistIndex]
        do {
            try FirebaseManager.shared.database.collection("checklists")
                .document(checklistId)
                .setData(from: updatedChecklist) { error in
                    if let error = error {
                        print("Failed to add item to Firestore: \(error)")
                    } else {
                        print("Item successfully added to Firestore")
                    }
                }
        } catch {
            print("Failed to update checklist in Firestore: \(error)")
        }
    }
     */

    // Delete Checklist
    func deleteChecklist(withId id: String?) {
            guard let id else {
                errorMessage = "Invalid checklist ID."
                return
            }
            FirebaseManager.shared.database.collection("checklists").document(id).delete { error in
                if let error {
                    self.errorMessage = "Failed to delete checklist: \(error.localizedDescription)"
                    return
                }
                self.errorMessage = nil
            }
        }
    
   // Add Item
 /*   func addItem(name: String, quantity: String, category: ItemCategory) {
        guard let quantityInt = Int(quantity), !name.isEmpty else { return }
        let newItem = Item(id: UUID().uuidString, name: name, quantity: quantityInt, category: category)
        self.currentItems.append(newItem)
    }
  */
    func addItem(name: String, quantity: String, category: ItemCategory) {
        guard !name.isEmpty else { return }
        let newItem = Item(id: UUID().uuidString, name: name, quantity: quantity, category: category)
        self.currentItems.append(newItem)
    }
    
  // Delete Add Item
    func deleteAddItem(at offsets: IndexSet) {
        self.currentItems.remove(atOffsets: offsets)
    }
    
   // Delete Item
    func deleteItem(_ item: Item, from checklistId: String) {
            guard let checklistIndex = lists.firstIndex(where: { $0.id == checklistId }) else {
                errorMessage = "Checklist not found."
                return
            }
            guard let itemId = item.id else {
                errorMessage = "Item ID is invalid."
                return
            }
            if let itemIndex = lists[checklistIndex].items.firstIndex(where: { $0.id == itemId }) {
                lists[checklistIndex].items.remove(at: itemIndex)
            } else {
                errorMessage = "Item not found in checklist."
                return
            }
            let updatedChecklist = lists[checklistIndex]
            do {
                try FirebaseManager.shared.database.collection("checklists")
                    .document(checklistId)
                    .setData(from: updatedChecklist) { error in
                        if let error {
                            self.errorMessage = "Failed to delete item from checklist: \(error.localizedDescription)"
                        } else {
                            self.errorMessage = nil
                        }
                    }
            } catch {
                errorMessage = "Failed to update checklist."
            }
        }
    
    // Change Status
    func toggleCompletion(for item: Item, checklistId: String?) {
        guard let checklistIndex = lists.firstIndex(where: { $0.id == checklistId }),
              let itemId = item.id,
              let itemIndex = lists[checklistIndex].items.firstIndex(where: { $0.id == itemId }) else {
            print("Checklist or Item not found")
            return
        }
        
        lists[checklistIndex].items[itemIndex].isCompleted.toggle()
        
        let updatedChecklist = lists[checklistIndex]
        do {
            try FirebaseManager.shared.database.collection("checklists")
                .document(checklistId ?? "")
                .setData(from: updatedChecklist) { error in
                    if let error = error {
                        print("Failed to update checklist in Firestore: \(error)")
                    } else {
                        print("Item completion status updated in Firestore")
                    }
                }
        } catch {
            print("Failed to update checklist in Firestore: \(error)")
        }
    }
    // Category Emotes
    func emote(for category: ItemCategory) -> String {
           switch category {
           case .hygiene: return "🪥"
           case .clothing: return "👕"
           case .equipment: return "🏕️"
           case .firstAid: return "⛑️"
           case .documents: return "🪪"
           case .food: return "🍽️"
           case .others: return "💠"
           }
       }
}

/*
 
 import Foundation
 import Firebase
 import FirebaseAuth
 import FirebaseFirestore

 class PreperationViewModel: ObservableObject {
     
     @Published var lists: [Checklist] = []
     @Published var currentItems: [Item] = []
     @Published var errorMessage: String? = nil

   
     // create Checklist
     func createChecklist(title: String, items: [Item]) {
         guard let userId = FirebaseManager.shared.userId else { return }
         let checklist = Checklist(id: nil, userId: userId, title: title, items: items)
         do {
             try FirebaseManager.shared.database.collection("checklists").addDocument(from: checklist)
             self.lists.append(checklist)
             self.currentItems.removeAll()
         } catch let error {
             print("Failed to save Checklist: \(error)")
         }
     }
     
     // Fetch Checklists
     func fetchChecklists() {
         guard let userId = FirebaseManager.shared.userId else {
             print("User ID not found")
             return
         }
         FirebaseManager.shared.database.collection("checklists")
             .whereField("userId", isEqualTo: userId)
             .addSnapshotListener { querySnapshot, error in
                 if let error = error {
                     print("Failed to fetch checklists: \(error)")
                     return
                 }
                 guard let documents = querySnapshot?.documents else {
                     print("No documents found for checklists")
                     return
                 }
                 self.lists = documents.compactMap {
                     do {
                         let checklist = try $0.data(as: Checklist.self)
                         print("Fetched checklist: \(checklist)")
                         return checklist
                     } catch {
                         print("Failed to decode checklist: \(error)")
                         return nil
                     }
                 }
                 print("Final lists: \(self.lists.map { $0.id ?? "nil" })")
             }
     }

     // update
     func updateChecklist(with id: String?, title: String) {
         guard let id else { return }
         let data = ["title": title]
         FirebaseManager.shared.database.collection("checklists").document(id).updateData(data) { error in
             if let error {
                 print("Failed to update Checklist", error)
                 return
             }
             print("Checklist updated!")
         }
     }
     
     // add Item to Checklist
     func addItemToChecklist(name: String, quantity: String, category: ItemCategory, checklistId: String) {
           guard !name.isEmpty else {
               print("Invalid input: Name is '\(name)' and Quantity is '\(quantity)'")
               return
           }
           guard let checklistIndex = lists.firstIndex(where: { $0.id == checklistId }) else {
               print("Checklist not found in local data. Checklist ID: \(checklistId)")
               print("Available checklists: \(lists.map { $0.id ?? "nil" })")
               return
           }
           let newItem = Item(id: UUID().uuidString, name: name, quantity: quantity, category: category)
           lists[checklistIndex].items.append(newItem)
           let updatedChecklist = lists[checklistIndex]
           do {
               try FirebaseManager.shared.database.collection("checklists")
                   .document(checklistId)
                   .setData(from: updatedChecklist) { error in
                       if let error = error {
                           print("Failed to add item to Firestore: \(error)")
                       } else {
                           print("Item successfully added to Firestore")
                       }
                   }
           } catch {
               print("Failed to update checklist in Firestore: \(error)")
           }
       }
     /*
     func addItemToChecklist(name: String, quantity: String, category: ItemCategory, checklistId: String) {
         guard let quantityInt = Int(quantity), !name.isEmpty else {
             print("Invalid input: Name is '\(name)' and Quantity is '\(quantity)'")
             return
         }
         guard let checklistIndex = lists.firstIndex(where: { $0.id == checklistId }) else {
             print("Checklist not found in local data. Checklist ID: \(checklistId)")
             print("Available checklists: \(lists.map { $0.id ?? "nil" })")
             return
         }
         let newItem = Item(id: UUID().uuidString, name: name, quantity: quantityInt, category: category)
         lists[checklistIndex].items.append(newItem)
         let updatedChecklist = lists[checklistIndex]
         do {
             try FirebaseManager.shared.database.collection("checklists")
                 .document(checklistId)
                 .setData(from: updatedChecklist) { error in
                     if let error = error {
                         print("Failed to add item to Firestore: \(error)")
                     } else {
                         print("Item successfully added to Firestore")
                     }
                 }
         } catch {
             print("Failed to update checklist in Firestore: \(error)")
         }
     }
      */

     // Delete Checklist
     func deleteChecklist(withId id: String?) {
         guard let id else { return }
         
         FirebaseManager.shared.database.collection("checklists").document(id).delete() { error in
             if let error {
                 print("Failed to delete checklist", error)
                 return
             }
             print("Checklist with ID \(id) successfully deleted")
         }
     }
     
    // Add Item
  /*   func addItem(name: String, quantity: String, category: ItemCategory) {
         guard let quantityInt = Int(quantity), !name.isEmpty else { return }
         let newItem = Item(id: UUID().uuidString, name: name, quantity: quantityInt, category: category)
         self.currentItems.append(newItem)
     }
   */
     func addItem(name: String, quantity: String, category: ItemCategory) {
         guard !name.isEmpty else { return }
         let newItem = Item(id: UUID().uuidString, name: name, quantity: quantity, category: category)
         self.currentItems.append(newItem)
     }
     
   // Delete Add Item
     func deleteAddItem(at offsets: IndexSet) {
         self.currentItems.remove(atOffsets: offsets)
     }
     
    // Delete Item
     func deleteItem(_ item: Item, from checklistId: String) {
         guard let checklistIndex = lists.firstIndex(where: { $0.id == checklistId }),
               let itemId = item.id else {
             print("Checklist or Item not found")
             return
         }
         if let itemIndex = lists[checklistIndex].items.firstIndex(where: { $0.id == itemId }) {
             lists[checklistIndex].items.remove(at: itemIndex)
         } else {
             print("Item not found in checklist")
             return
         }
         let updatedChecklist = lists[checklistIndex]
         do {
             try FirebaseManager.shared.database.collection("checklists")
                 .document(checklistId)
                 .setData(from: updatedChecklist) { error in
                     if let error = error {
                         print("Failed to update checklist in Firestore: \(error)")
                     } else {
                         print("Item successfully deleted from Firestore")
                     }
                 }
         } catch {
             print("Failed to update checklist in Firestore: \(error)")
         }
     }
     // Change Status
     func toggleCompletion(for item: Item, checklistId: String?) {
         guard let checklistIndex = lists.firstIndex(where: { $0.id == checklistId }),
               let itemId = item.id,
               let itemIndex = lists[checklistIndex].items.firstIndex(where: { $0.id == itemId }) else {
             print("Checklist or Item not found")
             return
         }
         
         lists[checklistIndex].items[itemIndex].isCompleted.toggle()
         
         let updatedChecklist = lists[checklistIndex]
         do {
             try FirebaseManager.shared.database.collection("checklists")
                 .document(checklistId ?? "")
                 .setData(from: updatedChecklist) { error in
                     if let error = error {
                         print("Failed to update checklist in Firestore: \(error)")
                     } else {
                         print("Item completion status updated in Firestore")
                     }
                 }
         } catch {
             print("Failed to update checklist in Firestore: \(error)")
         }
     }
     // Category Emotes
     func emote(for category: ItemCategory) -> String {
            switch category {
            case .hygiene: return "🪥"
            case .clothing: return "👕"
            case .equipment: return "🏕️"
            case .firstAid: return "⛑️"
            case .documents: return "🪪"
            case .food: return "🍽️"
            case .others: return "💠"
            }
        }
 }


 */
