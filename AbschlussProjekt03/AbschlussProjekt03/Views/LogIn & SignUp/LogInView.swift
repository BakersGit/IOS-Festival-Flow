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
            Image("Image 1")
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 140))
                .frame(width: 280, height: 280)
                .padding(.top, 50)
                .padding(.bottom, 20)
                .scaleEffect(isAnimating ? 1.00 : 0.9)
                .rotationEffect(isAnimating ? .degrees(0.5) : .degrees(-0.5))
                .animation(
                    Animation.easeInOut(duration: 0.9).repeatForever(autoreverses: true),
                    value: isAnimating
                )
                .onAppear {
                    isAnimating = true
                }

            Text("Festival Flow")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.purple)
                .padding(.bottom, 55)
            Spacer()
            Divider()
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
            Divider()
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
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
    LogInView()
        .environmentObject(LogInViewModel())
}
