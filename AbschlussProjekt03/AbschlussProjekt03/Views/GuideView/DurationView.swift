import SwiftUI

struct DurationView: View {
    @State private var festivalDuration: Int = 1
    @State private var showGuideResult: Bool = false
    @EnvironmentObject var preperationViewModel: PreperationViewModel
    @StateObject private var guideViewModel = GuideViewModel()

    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button(action: {
                    if festivalDuration > 1 {
                        festivalDuration -= 1
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title)
                        .foregroundColor(.red)
                }
                Spacer()
                
                Text("\(festivalDuration) Days")
                    .font(.headline)
                    .padding(.horizontal, 20)
                Spacer()
                Button(action: {
                    if festivalDuration < 14 {
                        festivalDuration += 1
                    }
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.3)))
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
               
                showGuideResult = true
            }) {
                Text("Guide Me")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            Spacer()
        }
        .padding(.bottom, 50)
        .background {
            Image(.main)
                .resizable()
                .scaledToFill()
                .frame(width: 420, height: 450)
                .blur(radius: 1)
                .offset(y: -25)
        }
        .sheet(isPresented: $showGuideResult) {
            GuideResultView(duration: festivalDuration) { items in
                let checklistTitle = "Suggestion for \(festivalDuration) Days"
                preperationViewModel.createChecklist(title: checklistTitle, items: items)
            }
            .environmentObject(guideViewModel)
        }
    }
}
