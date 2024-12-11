
import SwiftUI

struct ChecklistDetailView: View {
    
    let checklist: Checklist
    @EnvironmentObject var viewModel: PreperationViewModel
    @Environment(\.dismiss) var dismiss
    @State private var newItemName: String = ""
    @State private var newItemQuantity: String = ""

    var body: some View {
        VStack {
            Button(action: {
                viewModel.deleteChecklist(withId: checklist.id)
                dismiss()
            }) {
                Text("Delete List")
                    .foregroundColor(.red)
                    .bold()
            }
            .padding(.bottom, 10)
            
            VStack(spacing: 10) {
                HStack {
                    TextField("Item Name", text: $newItemName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Quantity", text: $newItemQuantity)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)
                        .keyboardType(.numberPad)
                    
                    Button(action: {
                        if let checklistId = checklist.id {
                            viewModel.addItemToChecklist(name: newItemName, quantity: newItemQuantity, checklistId: checklistId)
                            newItemName = ""
                            newItemQuantity = ""
                        } else {
                            print("Checklist ID is nil")
                        }
                    }) {
                        Text("Add")
                            .bold()
                            .frame(maxWidth: 80, minHeight: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(newItemName.isEmpty || newItemQuantity.isEmpty)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
            
            List {
                ForEach(checklist.items, id: \.id) { item in
                    HStack {
                        Text(item.name)
                            .font(.headline)
                        Spacer()
                        Text("x\(item.quantity)")
                            .foregroundColor(.gray)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            if let checklistId = checklist.id {
                                viewModel.deleteItem(item, from: checklistId)
                            }
                        } label: {
                            Text("Delete")
                        }
                    }
                }
            }
        }
        .navigationTitle(checklist.title)
    }
}

