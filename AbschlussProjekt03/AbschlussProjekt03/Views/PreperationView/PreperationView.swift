import SwiftUI
struct PreperationView: View {
    @StateObject private var viewModel = PreperationViewModel()
    @State private var isAddingNewList = false
    
    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            HStack {
                Text("Preparation")
                    .font(.title)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.white.opacity(0.3),
                                     Color.purple.opacity(0.8), Color.purple.opacity(0.9)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .padding(.horizontal, 15)

                Spacer()
                Button(action: {
                    isAddingNewList = true
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundStyle(LinearGradient(
                            colors: [.green, .blue],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: 40, height: 40)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.8))
                                .frame(width: 45, height: 45)
                        )
                }
            }
            .padding(.top)
            
            if viewModel.lists.isEmpty {
                Text("No lists available")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(viewModel.lists) { checklist in
                    NavigationLink(checklist.title){
                        ChecklistDetailView(checklist: checklist)
                            .environmentObject(viewModel)
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .background {
            Image("LogIn1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
        .sheet(isPresented: $isAddingNewList) {
            AddNewListSheet(
                isPresented: $isAddingNewList,
                viewModel: viewModel
            )
            .presentationDetents([.fraction(0.75)])
        }
        .onAppear {
            viewModel.fetchChecklists()
        }
    }
}
