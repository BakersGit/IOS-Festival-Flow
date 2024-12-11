import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("darkMode") var darkMode: Bool = false
    @AppStorage("language") var appLanguage: String = "Deutsch"
    
    
    @EnvironmentObject var logInViewModel: LogInViewModel
    var language = ["English", "Deutsch", "Französisch"]
    @State private var notifications: Bool = true
    @State private var showAlert: Bool = false
    
    var body: some View {
        Form {
            Text("Settings").font(.system(size: 40)).bold()
            
            Section(header: Text("App-Settings")) {
                Toggle("Dark Mode", isOn: $darkMode)
                    .tint(.purple)
                
                Toggle("Notifications", isOn: $notifications)
                    .tint(.purple)
                
                Picker("Language", selection: $appLanguage) {
                    ForEach(language, id: \.self) { language in
                        Text(language)
                    }
                }
                
                Button("Logout") {
                    showAlert = true
                }
                .foregroundColor(.red)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Logout"),
                        message: Text("You are about to log out. Are you sure?"),
                        primaryButton: .destructive(Text("Log out")) {
                            logInViewModel.signOut()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
        .scrollContentBackground(.hidden)
        .preferredColorScheme(darkMode ? .dark : .light)
    }
}

