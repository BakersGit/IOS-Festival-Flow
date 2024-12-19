import SwiftUI

struct DurationView: View {
    @State private var festivalDuration: Int = 1
    @State private var showGuideResult: Bool = false
    @EnvironmentObject var preperationViewModel: PreperationViewModel
    @StateObject private var guideViewModel = GuideViewModel()

    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("Plan Your Festival")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Text("Adjust the duration and get personalized suggestions.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Button(action: {
                    if festivalDuration > 1 {
                        festivalDuration -= 1
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title)
                        .foregroundStyle(LinearGradient(
                            colors: [.red, .orange],
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: 40, height: 40)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 50, height: 50)
                        )
                }

                Spacer()
                
                Text("\(festivalDuration) Days")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                Button(action: {
                    if festivalDuration < 14 {
                        festivalDuration += 1
                    }
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
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 50, height: 50)
                        )
                }
            }
            .padding()
            .padding(.horizontal)

            Spacer()

            Button(action: {
                showGuideResult = true
            }) {
                Text("Guide Me")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 250)
                    .padding(.vertical, 12)
                    .background(.purple.gradient, in: Capsule())
                    .padding(.bottom, 15)
                    .padding(.top, 15)
            }
            
            Spacer()
        }
        .padding(.bottom, 50)
        .sheet(isPresented: $showGuideResult) {
            GuideResultView(duration: festivalDuration) { items in
                let checklistTitle = "Suggestion for \(festivalDuration) Days"
                preperationViewModel.createChecklist(title: checklistTitle, items: items)
            }
            .environmentObject(guideViewModel)
        }
        .presentationDetents([.fraction(0.5)])
        .presentationDragIndicator(.visible)
        .background(
            Image("Duration2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}
