
import SwiftUI

struct EventScrollView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.events, id: \.id) { event in
                    EventCardView(event: event, viewModel: viewModel)
                        .frame(width: 250)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 200)
    }
}

