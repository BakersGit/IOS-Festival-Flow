import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("darkMode") var darkMode: Bool = false
    @AppStorage("language") var appLanguage: String = "English"
    
    @EnvironmentObject var logInViewModel: LogInViewModel
    var language = ["English", "German", "French", "Spanish"]
    @State private var notifications: Bool = true
    @State private var showAlert: Bool = false
    @State private var showLanguageAlert: Bool = false
    
    var body: some View {
        Form {
            Text("Profile").font(.system(size: 30)).bold()
            
            Section(header: Text("User-Data")) {
                if let user = logInViewModel.user {
                    Text("Username: \(user.username)")
                    Text("Email: \(user.email)")
                } else {
                    Text("No user data available.")
                        .foregroundColor(.gray)
                }
            }
            
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
                .onChange(of: appLanguage) {
                    if appLanguage == "German" || appLanguage == "French" {
                        showLanguageAlert = true
                    }
                }
                .alert(isPresented: $showLanguageAlert) {
                    Alert(
                        title: Text("Translations Not Ready"),
                        message: Text("Translations in other languages have not been completed yet."),
                        dismissButton: .default(Text("OK"), action: {
                            appLanguage = "English"
                        })
                    )
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
        .background {
            Image("LogIn1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .preferredColorScheme(darkMode ? .dark : .light)
    }
}
