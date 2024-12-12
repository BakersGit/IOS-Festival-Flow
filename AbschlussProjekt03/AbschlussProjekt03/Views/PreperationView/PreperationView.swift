

import SwiftUI

struct PreperationView: View {
    @StateObject private var viewModel = PreperationViewModel()
    @State private var isAddingNewList = false


    var body: some View {
        VStack {
            HStack {
                Text("Preparation")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                Spacer()
                Button(action: {
                    isAddingNewList = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .padding()
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
                
            }
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
