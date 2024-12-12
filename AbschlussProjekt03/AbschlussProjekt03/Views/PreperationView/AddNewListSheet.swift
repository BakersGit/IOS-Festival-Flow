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
                .frame(maxHeight: 100)
                
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
                            viewModel.addItem(name: newItemName, quantity: newItemQuantity, category: selectedCategory)
                            newItemName = ""
                            newItemQuantity = ""
                            selectedCategory = .others
                        }) {
                            Image(systemName: "plus")
                                .frame(maxWidth: 50)
                                .padding(10)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
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
            
            HStack {
                Button(action: {
                    viewModel.currentItems.removeAll() 
                    isPresented = false
                }) {
                    Text("Cancel")
                        .frame(maxWidth: 100)
                        .padding(10)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    viewModel.createChecklist(title: title, items: viewModel.currentItems)
                    isPresented = false
                }) {
                    Text("Save List")
                        .frame(maxWidth: 100)
                        .padding(10)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(title.isEmpty || viewModel.currentItems.isEmpty)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}
