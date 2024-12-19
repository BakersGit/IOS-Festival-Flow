
import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth

@main
struct AbschlussProjekt03App: App {
    
    @StateObject private var logInViewModel = LogInViewModel()
    @StateObject private var preperationViewModel = PreperationViewModel()
    @AppStorage("darkMode") var darkMode: Bool = false
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if isFirstLaunch {
                SplashView(isFirstLaunch: $isFirstLaunch)
            } else if !logInViewModel.isLoggedIn {
                NavigationStack {
                    LogInView()
                }
            } else {
                NavigationStack {
                    MainScreenView()
                        .preferredColorScheme(darkMode ? .dark : .light)
                }
            }
        }
        .environmentObject(self.logInViewModel)
        .environmentObject(self.preperationViewModel)
    }
}
