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
    
    var completionPercentage: Double {
        let totalItems = checklist.items.count
        let completedItems = checklist.items.filter { $0.isCompleted }.count
        guard totalItems > 0 else { return 0 }
        return Double(completedItems) / Double(totalItems)
    }
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundColor(.gray)
                    
                    Circle()
                        .trim(from: 0, to: completionPercentage)
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [.red, .brown, .blue, .purple]),
                                center: .center
                            ),
                            style: StrokeStyle(lineWidth: 20, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut, value: completionPercentage)
                    
                    VStack {
                        Text("\(Int(completionPercentage * 100))%")
                            .font(.largeTitle)
                            .bold()
                        Text("Complete")
                            .font(.caption)
                            .foregroundColor(completionPercentage == 1.0 ? .green : .secondary) 
                    }
                }
                .frame(width: 150, height: 150)
                .padding(.bottom, 20)
            }
            .padding(.top, 15)
            
            HStack {
                Button(action: {
                    showDeleteAlert = true
                }) {
                    Text("Delete List")
                        .foregroundColor(.red)
                        .bold()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black.opacity(0.6))
                                .frame(width: 95, height: 45)
                        )
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
                                .fill(Color.black.opacity(0.6))
                                .frame(width: 45, height: 45)
                        )
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
            .scrollContentBackground(.hidden)
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
        .background(
            Image("LogIn1")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}
