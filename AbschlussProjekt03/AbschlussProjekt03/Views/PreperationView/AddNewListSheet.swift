

import SwiftUI

struct AddNewListSheet: View {
    
    @Binding var isPresented: Bool
    @State private var title = ""
    @State private var newItemName = ""
    @State private var newItemQuantity = ""
    @ObservedObject var viewModel: PreperationViewModel
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter Title", text: $title)
                }
                Section(header: Text("Add Items")) {
                    HStack {
                        TextField("Item name", text: $newItemName)
                        TextField("Quantity", text: $newItemQuantity)
                            .frame(width: 50)
                        Button(action: {
                            viewModel.addItem(name: newItemName, quantity: newItemQuantity)
                            newItemName = ""
                            newItemQuantity = ""
                        }) {
                            Image(systemName: "plus")
                        }
                        .disabled(newItemName.isEmpty || newItemQuantity.isEmpty)
                    }
                    
                    List {
                        ForEach(viewModel.currentItems) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text("Amount: \(item.quantity)")
                            }
                            .swipeActions {
                                Button("Löschen", role: .destructive) {
                                    if let index = viewModel.currentItems.firstIndex(of: item) {
                                        viewModel.deleteAddItem(at: IndexSet(integer: index))
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .padding()
                .foregroundColor(.red)
                
                Spacer()
                
                Button("Save") {
                    viewModel.createChecklist(title: title, items: viewModel.currentItems)
                    isPresented = false
                }
                .padding()
                .foregroundColor(.blue)
                .disabled(title.isEmpty || viewModel.currentItems.isEmpty)
            }
        }
    }
}
