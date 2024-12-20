import SwiftUI

struct GuideView: View {
    @State private var showDurationSheet: Bool = false
    @State private var showTippsSheet: Bool = false


    var body: some View {
        VStack(spacing: 20) {
          
            VStack(spacing: 10) {
                Text("Welcome to the Preperation Guide!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Text("Plan your Festival Experience with our dynamic guide.")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 50)
            
            Button(action: {
                showDurationSheet = true
            }) {
                Text("Start Planning")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 180)
                    .padding(.vertical, 12)
                    .background(.purple.gradient, in: Capsule())
                    .padding(.bottom, 15)
                    .padding(.top, 15)
            }
            Text("Your first Adventure awaits?")
                .font(.body)
                .foregroundColor(.white)
                .padding(.horizontal)
            Button(action: {
                showTippsSheet = true
            }) {
                Text("Tipps & Advice")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 180)
                    .padding(.vertical, 12)
                    .background(.purple.gradient, in: Capsule())
                    .padding(.bottom, 15)
                    .padding(.top, 10)
            }

            Spacer()
        }
        .sheet(isPresented: $showDurationSheet) {
            DurationView()
        }
        .sheet(isPresented: $showTippsSheet) {
            TippsView()
        }
        .padding()
        .background {
            Image("LogIn1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    GuideView()
}
