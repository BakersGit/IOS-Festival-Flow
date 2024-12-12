import SwiftUI

struct GuideResultView: View {
    let duration: Int
    let onAddToPreparation: ([Item]) -> Void
    @EnvironmentObject var guideViewModel: GuideViewModel
    @EnvironmentObject var viewModel: PreperationViewModel
    @Environment(\.dismiss) var dismiss
    
    var suggestedItems: [Item] {
        guideViewModel.dayLists[duration] ?? []
    }
    
    var body: some View {
        VStack {
            Text("Suggested Items for \(duration) Days")
                .font(.headline)
                .padding()
            
            List {
                ForEach(ItemCategory.allCases, id: \.self) { category in
                    Section(header: Text("\(viewModel.emote(for: category)) \(category.rawValue)")) {
                        ForEach(suggestedItems.filter { $0.category == category }) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                Text("x\(item.quantity)")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            
            VStack(spacing: 10) {
                Button(action: {
                    onAddToPreparation(suggestedItems)
                    dismiss()
                }) {
                    Text("Add to Preparation")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom)
        }
    }
}
