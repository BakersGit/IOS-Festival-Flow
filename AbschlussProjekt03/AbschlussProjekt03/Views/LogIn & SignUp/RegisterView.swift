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
 /*           Image("Image 1")
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 300, height: 300)
                .padding(.top, 10)
                .padding(.bottom, 20)
  */
            Text("Register").font(.title).bold().foregroundStyle(.purple)
            Spacer()
            Divider()
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
            Divider()
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
            Divider()
            TextField("Confirm Email", text: $emailConfirm)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
            Divider()
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 20)
            Divider()
            SecureField("Confirm Password", text: $passwordConfirm)
                .textFieldStyle(.roundedBorder)
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
        .background {
            Image(.log)
                .resizable()
                .scaledToFill()
                .frame(width: 420, height: 420)
                .ignoresSafeArea()
        }
    }
}
#Preview {
    RegisterView()
        .environmentObject(LogInViewModel())
}
