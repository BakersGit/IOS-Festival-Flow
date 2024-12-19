import SwiftUI

struct AddItemSheet: View {
    let checklistId: String?
    @Binding var showSheet: Bool
    @State private var newItemName: String = ""
    @State private var newItemQuantity: String = ""
    @State private var selectedCategory: ItemCategory = .others
    @ObservedObject var viewModel: PreperationViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Add New Item")
                .font(.headline)
                .padding(.top, 20)
            
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Name", text: $newItemName)
                        .focused($isFocused)
                        .onAppear {
                            isFocused = true
                        }
                    
                    TextField("Quantity", text: $newItemQuantity)
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(ItemCategory.allCases) { category in
                            Text("\(viewModel.emote(for: category)) \(category.rawValue)")
                                .tag(category)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            
            HStack {
                Button(action: {
                    showSheet = false
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: 180)
                        .padding(.vertical, 12)
                        .background(.red.gradient, in: Capsule())
                }

                Button(action: {
                    if let checklistId = checklistId, !newItemName.isEmpty, !newItemQuantity.isEmpty {
                        viewModel.addItemToChecklist(
                            name: newItemName,
                            quantity: newItemQuantity,
                            category: selectedCategory,
                            checklistId: checklistId
                        )
                        showSheet = false
                    }
                }) {
                    Text("Save")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: 180) 
                        .padding(.vertical, 12)
                        .background(.purple.gradient, in: Capsule())
                }
                .disabled(newItemName.isEmpty || newItemQuantity.isEmpty)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(
            Image("Duration2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
