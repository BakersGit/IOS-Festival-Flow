import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct LogInView: View {
    @EnvironmentObject var logInViewModel: LogInViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Text("Festival Flow")
                .font(.custom("Times New Roman", size: 38))
                .fontWeight(.regular)
                .foregroundStyle(.purple.gradient)
                .padding(.top, 50)
            
            ZStack {
                Image("Image 3")
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 140))
                    .frame(width: 220, height: 280)
                    .scaleEffect(isAnimating ? 1.00 : 0.9)
                    .rotationEffect(isAnimating ? .degrees(0.5) : .degrees(-0.5))
                    .animation(
                        Animation.easeInOut(duration: 0.9).repeatForever(autoreverses: true),
                        value: isAnimating
                    )
                    .onAppear {
                        isAnimating = true
                    }
                
            }
            .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Your Festival,")
                        .font(.custom("Times New Roman", size: 24))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.7),
                                    Color.white.opacity(0.4)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("Your Adventure,")
                        .font(.custom("Times New Roman", size: 24))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.7),
                                    Color.white.opacity(0.4)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("Your Flow.")
                        .font(.custom("Times New Roman", size: 24))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [
                                    Color.purple.opacity(0.9),
                                    Color.purple.opacity(0.6)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .padding(.trailing, 20)
                }
            }
            
            .padding()
            
            Spacer()
            
            Divider()
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
            if let emailError = logInViewModel.emailError {
                Text(emailError)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.horizontal, 30)
            }
            
            Divider()
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
            if let passwordError = logInViewModel.passwordError {
                Text(passwordError)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.horizontal, 30)
            }
            
            Divider()
            
            Button("Log in") {
                logInViewModel.signIn(email: email, password: password)
            }
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(width: 150)
            .padding(.vertical, 12)
            .background(.purple.gradient, in: .capsule)
            .padding(.bottom, 15)
            .padding(.top, 15)
            
            if let signInError = logInViewModel.signInError {
                Text(signInError)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.horizontal, 30)
            }
            
            /*           Button("Log In as Anonymous") {
             logInViewModel.signInAnonymously()
             }
             .buttonStyle(.borderedProminent)
             .tint(.gray)
             .padding(.bottom, 15)
             */
            
            NavigationLink("No Account yet? Register here!", destination: {
                RegisterView()
            })
            .padding(.bottom, 10)
        }
        .background {
            Image("LogIn1")
                .resizable()
                .scaledToFill()
                .frame(width: 420, height: 420)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    LogInView()
        .environmentObject(LogInViewModel())
}
