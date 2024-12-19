import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    @EnvironmentObject var logInViewModel: LogInViewModel
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var emailConfirm: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""

    var body: some View {
        VStack {
            Text("Sign up")
                .font(.title)
                .bold()
                .foregroundStyle(.purple)
                .padding()

            Spacer()

            VStack(spacing: 15) {
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)

                if let error = logInViewModel.registrationError {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.horizontal, 20)
                }

                TextField("E-mail address", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 20)

                if let error = logInViewModel.emailError {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.horizontal, 20)
                }

                TextField("Confirm E-mail address", text: $emailConfirm)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal, 20)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)

                SecureField("Confirm Password", text: $passwordConfirm)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)

                if let error = logInViewModel.passwordError {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.horizontal, 20)
                }
            }

            Button("Sign up!") {
                guard email == emailConfirm else {
                    logInViewModel.emailError = "The E-mail addresses do not match."
                    return
                }
                guard password == passwordConfirm else {
                    logInViewModel.passwordError = "The Passwords do not match."
                    return
                }
                logInViewModel.register(username: username, email: email, password: password, passwordConfirm: passwordConfirm)
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            .padding(.top, 15)
            .padding(.bottom, 15)

            Spacer()
        }
        .background(
            Image("LogIn1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}

#Preview {
    RegisterView()
        .environmentObject(LogInViewModel())
}
