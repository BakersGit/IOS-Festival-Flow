import SwiftUI

struct TippsView: View {
    @State private var expandedEventIndex: Int? = nil
    let events = [
        ("Goa Festival", "GoaFestival"),
        ("Art Festival", "ArtFestival"),
        ("Concert", "Concert"),
        ("Rock Festival", "RockFestival"),
        ("EDM Festival", "EDMFestival"),
        ("HipHop Festival", "HipHopFestival")
    ]

    var body: some View {
        VStack {
            Spacer()

            Text("Tipps & Advice")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)

            Text("Check the Event-Type-Images below for more.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

            ScrollView {
                ForEach(events.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(events[index].0)
                            .font(.headline)
                            .foregroundColor(.white)

                        Image(events[index].1)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .cornerRadius(10)
                            .clipped()

                        Button(action: {
                            withAnimation {
                                expandedEventIndex = (expandedEventIndex == index ? nil : index)
                            }
                        }) {
                            Text(expandedEventIndex == index ? "Hide Details" : "All you need to know")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, minHeight: 30)
                                .background(Color.white.opacity(0.8))
                                .foregroundStyle(.purple)
                                .cornerRadius(5)
                        }

                        if expandedEventIndex == index {
                            Text("Know How about \(events[index].0). These Informations are under Construction right now. Please come back later to get some useful Advice for your Adventure")
                                .font(.body)
                                .foregroundColor(.white)
                                .padding(.top, 5)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }

            Spacer()
        }
        .padding()
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

#Preview {
    TippsView()
}
