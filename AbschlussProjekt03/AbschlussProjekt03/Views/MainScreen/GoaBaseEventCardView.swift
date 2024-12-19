import SwiftUI

struct GoaBaseEventCardView: View {
    let event: Festival
    @ObservedObject var viewModel: MainViewModel
    @State private var showDetails: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.name)
                .font(.headline)
                .padding(.bottom, 2)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Start Date: \(formattedDate(from: event.startDate))")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("End Date: \(formattedDate(from: event.endDate))")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            if let imageUrl = URL(string: event.image.url) {
                AsyncImage(url: imageUrl) { image in
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
                    Text("Description: \(event.description)")
                        .font(.body)
                        .padding(.bottom, 8)
                    
                    if let locationName = event.location.name {
                        Text("Location: \(locationName)")
                            .font(.body)
                    }
                    Text("Country: \(event.location.address.addressCountry)")
                        .font(.body)
                    
                    if let url = URL(string: event.url) {
                        Button(action: {
                            UIApplication.shared.open(url)
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
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.5)))
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.5)))
    }
    
    private func formattedDate(from isoDate: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: isoDate) else { return isoDate }
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .medium
        return outputFormatter.string(from: date)
    }
}
