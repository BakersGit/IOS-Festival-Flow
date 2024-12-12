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
                    .background(Color.gray.opacity(0.4))
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(event.images, id: \.url) { image in
                                AsyncImage(url: URL(string: image.url)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 120, height: 120)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.5)))
                
                Button(action: {
                    if let url = URL(string: event.url) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Tickets")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, minHeight: 30)
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.purple)
                        .cornerRadius(5)
                }
        }
    }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.5)))
}
}

/*
 .padding()
 .frame(maxWidth: .infinity)
 .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
 }
 }
 .padding()
 .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 5))
 }
 }
 */
