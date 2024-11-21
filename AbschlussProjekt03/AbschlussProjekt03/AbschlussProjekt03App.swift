import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth

@main
struct AbschlussProjekt03App: App {
    
    @StateObject private var logInViewModel = LogInViewModel()
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            if !logInViewModel.isLoggedIn {
                NavigationStack {
                    LogInView()
                }
            } else {
                NavigationStack {
                    MainScreenView()
                }
            }
        }
        .environmentObject(self.logInViewModel)
    }
}
