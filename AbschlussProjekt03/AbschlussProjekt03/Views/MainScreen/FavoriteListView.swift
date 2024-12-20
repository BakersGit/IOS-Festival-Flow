// Künftiges Feature
import SwiftUI

struct FavoriteListView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        List(viewModel.favoriteEvents, id: \.id) { event in
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline)
                Text("Date: \(event.dates.start.localDate)")
                if let localTime = event.dates.start.localTime {
                    Text("Time: \(localTime)")
                }
            }
            .padding()
        }
        .listStyle(PlainListStyle())
    }
}

