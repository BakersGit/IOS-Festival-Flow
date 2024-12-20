import SwiftUI

struct EventCardView: View {
    let event: Event
    @ObservedObject var viewModel: MainViewModel
    @State private var showDetails: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.name)
                .font(.headline)
                .padding(.bottom, 2)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Date: \(event.dates.start.localDate)")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            if let firstImageURL = event.images.first?.url {
                AsyncImage(url: URL(string: firstImageURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 150)
                }
                .padding(.vertical, 8)
            }
            Button(action: {
                withAnimation {
                    showDetails.toggle()
                }
            }) {
                Text(showDetails ? "Hide Details" : "Details")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, minHeight: 30)
                    .background(Color.white)
                    .foregroundStyle(.purple)
                    .cornerRadius(5)
            }
            
            if showDetails {
                VStack(spacing: 8) {
                    Text("Name: \(event.name)")
                        .font(.body)
                    Text("Date: \(event.dates.start.localDate)")
                        .font(.body)
                    if let localTime = event.dates.start.localTime {
                        Text("Time: \(localTime)")
                    }
                    if let eventDescription = event.description {
                        Text(eventDescription)
                            .font(.body)
                            .padding(.top, 10)
                    } else {
                        Text("Description: Not available.")
                            .font(.body)
                            .padding(.top, 10)
                            .foregroundColor(.gray)
                        Text("Check the Ticket-Link below for more Informations.")
                            .font(.body)
                        .foregroundColor(.black)                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.5)))
                
                Button(action: {
                    if let url = URL(string: event.url) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("More Informations")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, minHeight: 30)
                        .background(Color.white)
                        .foregroundStyle(.purple)
                        .cornerRadius(5)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.black.opacity(0.6)))
    }
}

