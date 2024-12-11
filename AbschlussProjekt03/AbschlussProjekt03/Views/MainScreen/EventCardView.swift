
import SwiftUI

struct EventCardView: View {
    
    let event: Event
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.name)
                .font(.headline)
            
            Text("Date: \(event.dates.start.localDate)")
            if let localTime = event.dates.start.localTime {
                Text("Time: \(localTime)")
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(event.images, id: \.url) { image in
                        AsyncImage(url: URL(string: image.url)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .clipped()
                        } placeholder: {
                            ProgressView()
                                .frame(width: 120, height: 120)
                        }
                    }
                }
            }
            .frame(height: 130)

            Link("Details", destination: URL(string: event.url)!)
                .foregroundColor(.purple)
            
            Button(action: {
                viewModel.toggleFavorite(for: event)
            }) {
                Image(systemName: viewModel.isFavorite(event) ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.isFavorite(event) ? .red : .gray)
                    .frame(width: 35, height: 35)
                    .contentShape(Rectangle())
            }
            .padding(.top, 8)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
    }
}
#Preview {
    let exampleEvent = Event(
        id: "1",
        name: "Music Festival 2024",
        dates: EventDates(
            start: EventStart(localDate: "2024-12-15", localTime: "18:00")
        ),
        url: "https://www.example.com",
        images: [
            EventImage(url: "https://via.placeholder.com/150"),
            EventImage(url: "https://via.placeholder.com/150"),
            EventImage(url: "https://via.placeholder.com/150"),
            EventImage(url: "https://via.placeholder.com/150")
        ]
    )
    
    let exampleViewModel = MainViewModel()
    exampleViewModel.events = [exampleEvent]
    
    return EventCardView(event: exampleEvent, viewModel: exampleViewModel)
}
