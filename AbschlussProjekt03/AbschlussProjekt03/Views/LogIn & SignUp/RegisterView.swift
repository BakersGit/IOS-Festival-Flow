import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    
    @EnvironmentObject var logInViewModel: LogInViewModel
    @State var email: String = ""
    @State var emailConfirm: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var passwordConfirm: String = ""
    
    var body: some View {
        VStack {
            Image("Image 1")
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 300, height: 300)
                .padding(.top, 10)
                .padding(.bottom, 20)
            Text("Register").font(.title).bold()
            Spacer()
            Divider()
            TextField("Username", text: $username)
                .textFieldStyle(.plain)
                .padding(.horizontal, 20)
            Divider()
            TextField("Email", text: $email)
                .textFieldStyle(.plain)
                .padding(.horizontal, 20)
            Divider()
            TextField("Confirm Email", text: $emailConfirm)
                .textFieldStyle(.plain)
                .padding(.horizontal, 20)
            Divider()
            SecureField("Password", text: $password)
                .textFieldStyle(.plain)
                .padding(.horizontal, 20)
            Divider()
            SecureField("Confirm Password", text: $passwordConfirm)
                .textFieldStyle(.plain)
                .padding(.horizontal, 20)
            Divider()
            
            Button("Register") {
                logInViewModel.register(username: username, email: email, password: password)
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            .padding(.top, 15)
            .padding(.bottom, 15)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white, Color.purple.opacity(0.4)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
    }
}
#Preview {
    RegisterView()
        .environmentObject(LogInViewModel())
}
