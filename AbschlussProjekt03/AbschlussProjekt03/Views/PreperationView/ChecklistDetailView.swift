
import SwiftUI

struct ChecklistDetailView: View {
    
    let checklist: Checklist
    @EnvironmentObject var viewModel: PreperationViewModel
    @Environment(\.dismiss) var dismiss
    @State private var newItemName: String = ""
    @State private var newItemQuantity: String = ""
    @State private var selectedCategory: ItemCategory = .others
    @State private var showAddItemSheet: Bool = false
    @State private var showDeleteAlert: Bool = false
    
    
    var groupedItems: [ItemCategory: [Item]] {
        Dictionary(grouping: checklist.items, by: { $0.category })
            .filter { !$0.value.isEmpty }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    showDeleteAlert = true
                }) {
                    Text("Delete List")
                        .foregroundColor(.red)
                        .bold()
                }
                .alert(isPresented: $showDeleteAlert) {
                    Alert(
                        title: Text("Delete Checklist"),
                        message: Text("Are you sure you want to delete this Checklist? This Action cannot be undone."),
                        primaryButton: .destructive(Text("Delete")) {
                            viewModel.deleteChecklist(withId: checklist.id)
                            dismiss()
                        },
                        secondaryButton: .cancel()
                    )
                }
                Spacer()
                Button(action: {
                    showAddItemSheet = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .padding()
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            List {
                ForEach(groupedItems.keys.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { category in
                    Section(header: HStack {
                        Text("\(viewModel.emote(for: category)) \(category.rawValue)")
                            .font(.headline)
                    }) {
                        ForEach(groupedItems[category] ?? [], id: \.id) { item in
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundColor(item.isCompleted ? .gray : .primary)
                                    Text("x\(item.quantity)")
                                        .foregroundColor(item.isCompleted ? .gray : .secondary)
                                }
                                Spacer()
                                Image(systemName: item.isCompleted ? "checkmark.square" : "square")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(item.isCompleted ? .green : .gray)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.toggleCompletion(for: item, checklistId: checklist.id)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    if let checklistId = checklist.id {
                                        viewModel.deleteItem(item, from: checklistId)
                                    }
                                } label: {
                                    Text("Remove")
                                }
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddItemSheet) {
            AddItemSheet(
                checklistId: checklist.id,
                showSheet: $showAddItemSheet,
                viewModel: viewModel
            )
            .presentationDetents([.fraction(0.5)])
        }
        .navigationTitle(checklist.title)
    }
}
