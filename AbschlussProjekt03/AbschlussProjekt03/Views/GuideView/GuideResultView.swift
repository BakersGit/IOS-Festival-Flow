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
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if suggestedItems.isEmpty {
                Text("No items found for this duration.")
                    .foregroundColor(.red)
                    .padding()
            } else {
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
                .scrollContentBackground(.hidden)
                
                VStack(spacing: 10) {
                    Button(action: {
                        onAddToPreparation(suggestedItems)
                        dismiss()
                    }) {
                        Text("Add to Preparation")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: 180)
                            .padding(.vertical, 12)
                            .background(.purple.gradient, in: Capsule())
                    }

                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: 180)
                            .padding(.vertical, 12)
                            .background(.red.gradient, in: Capsule())
                    }
                }
                .padding(.bottom)
            }
        }
        .background(
            Image("Duration2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}
