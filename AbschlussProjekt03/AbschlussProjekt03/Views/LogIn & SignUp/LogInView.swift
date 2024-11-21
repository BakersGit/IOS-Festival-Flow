import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct LogInView: View {
    
    @EnvironmentObject var logInViewModel: LogInViewModel
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Image("Image 1")
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 300, height: 300)
                .padding(.top, 50)
                .padding(.bottom, 20)
            Text("FestivalFlow")
                .font(.title)
                .fontWeight(.heavy)
                .padding(.bottom, 55)
            Spacer()
            Divider()
            TextField("Email", text: $email)
                .textFieldStyle(.plain)
                .padding(.horizontal, 30)
            Divider()
            SecureField("Password", text: $password)
                .textFieldStyle(.plain)
                .padding(.horizontal, 30)
            Divider()
            
            Button("Login") {
                logInViewModel.signIn(email: email, password: password)
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            .padding(.bottom, 15)
            .padding(.top, 15)
            
            Button("Log In as Anonymous") {
                logInViewModel.signInAnonymously()
            }
            .buttonStyle(.borderedProminent)
            .tint(.gray)
            .padding(.bottom, 15)
            NavigationLink("No Account yet? Register here!", destination: {
                RegisterView()
            })
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white, Color.purple.opacity(0.4)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
    }
}
#Preview {
    LogInView()
        .environmentObject(LogInViewModel())
}
