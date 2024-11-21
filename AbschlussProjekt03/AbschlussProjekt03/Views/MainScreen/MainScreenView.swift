import SwiftUI
import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct MainScreenView: View {
    
    @EnvironmentObject var logInViewModel: LogInViewModel
    @State var isPresented: Bool = false
    @State private var alert = false
    
    var body: some View {
        VStack {
            Image("Image")
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 300, height: 300)
                .padding(.top, 50)
                .padding(.bottom, 20)
            Text("Content Coming Soon!")
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    alert = true
                } label: {
                    Text("Log out")
                }
            }
        }
        .alert(isPresented: $alert) {
            Alert(
                title: Text(""),
                message: Text("You are about to Log out. \nAre you sure about that?"),
                primaryButton: .destructive(Text("Log out")) {
                    logInViewModel.signOut()
                },
                secondaryButton: .cancel()
            )
        }
    }
}
#Preview {
    MainScreenView()
        .environmentObject(LogInViewModel())
}
