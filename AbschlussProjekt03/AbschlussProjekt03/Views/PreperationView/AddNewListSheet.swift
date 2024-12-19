import SwiftUI

struct AddNewListSheet: View {
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var newItemName: String = ""
    @State private var newItemQuantity: String = ""
    @State private var selectedCategory: ItemCategory = .others
    @ObservedObject var viewModel: PreperationViewModel
    @FocusState private var isTitleFieldFocused: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Add New Checklist")
                .font(.headline)
                .padding(.top, 20)
            
            Form {
                Section(header: Text("Checklist Title")) {
                    TextField("Enter Title", text: $title)
                        .focused($isTitleFieldFocused)
                        .onAppear {
                            isTitleFieldFocused = true
                        }
                }
                
                Section(header: Text("Add Items")) {
                    TextField("Item name", text: $newItemName)
                    TextField("Quantity", text: $newItemQuantity)
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(ItemCategory.allCases) { category in
                            Text("\(viewModel.emote(for: category)) \(category.rawValue)")
                                .tag(category)
                        }
                    }
                    
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.addItem(
                                name: newItemName,
                                quantity: newItemQuantity,
                                category: selectedCategory
                            )
                            newItemName = ""
                            newItemQuantity = ""
                            selectedCategory = .others
                        }) {
                            Text("Add Item")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: 180)
                                .padding(.vertical, 12)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.green, .purple]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    ),
                                    in: Capsule()
                                )
                        }
                        .disabled(newItemName.isEmpty || newItemQuantity.isEmpty)
                        Spacer()
                    }
                }
                
                List {
                    ForEach(viewModel.currentItems) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("Amount: \(item.quantity)")
                        }
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                if let index = viewModel.currentItems.firstIndex(of: item) {
                                    viewModel.deleteAddItem(at: IndexSet(integer: index))
                                }
                            }
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            
            HStack {
                Button(action: {
                    viewModel.currentItems.removeAll()
                    isPresented = false
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
                    viewModel.createChecklist(title: title, items: viewModel.currentItems)
                    isPresented = false
                }) {
                    Text("Save List")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: 180)
                        .padding(.vertical, 12)
                        .background(.purple.gradient, in: Capsule())
                }
                .disabled(title.isEmpty || viewModel.currentItems.isEmpty)
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
