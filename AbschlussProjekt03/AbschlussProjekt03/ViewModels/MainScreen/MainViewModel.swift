import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

@MainActor
class MainViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    @Published var favoriteEvents: [Event] = []
    @Published var searchQuery: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private let eventsRepository = EventRepository()
    private let firestore = Firestore.firestore()
    private let auth = Auth.auth()
    
    init() {
        Task {
            await loadUserFavorites()
        }
    }
    
    func fetchEvents() {
        isLoading = true
        errorMessage = nil
        Task {
            do {
                events = try await eventsRepository.getEventsFromAPI(keyword: searchQuery.isEmpty ? "Electronic" : searchQuery)
                await loadUserFavorites()
            } catch let error as HTTPError {
                errorMessage = error.message
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func toggleFavorite(for event: Event) {
        guard let userId = auth.currentUser?.uid else { return }
        Task {
            do {
                let userDocument = firestore.collection("users").document(userId)
                let document = try await userDocument.getDocument()
                var user = try document.data(as: FirestoreUser.self)
                
                if let index = user.favoriteEvents.firstIndex(of: event.id) {
                    user.favoriteEvents.remove(at: index)
                    favoriteEvents.removeAll(where: { $0.id == event.id })
                } else {
                    user.favoriteEvents.append(event.id)
                    favoriteEvents.append(event)
                }
                
                try userDocument.setData(from: user)
            } catch {
                print("Failed to update favorites: \(error)")
            }
        }
    }
    
    func isFavorite(_ event: Event) -> Bool {
        favoriteEvents.contains(where: { $0.id == event.id })
    }
    
    private func loadUserFavorites() async {
           guard let userId = auth.currentUser?.uid else {
               errorMessage = "User not logged in. Please sign in."
               return
           }
           do {
               let document = try await firestore.collection("users").document(userId).getDocument()
               let user = try document.data(as: FirestoreUser.self)
               let favoriteEventIds = user.favoriteEvents
               favoriteEvents = events.filter { favoriteEventIds.contains($0.id) }
           } catch {
               errorMessage = "Failed to load favorite events. Please try again."
           }
       }
}
