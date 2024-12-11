//
//  Test.swift
//  AbschlussProjekt03
//
//  Created by Kai Becker on 24.11.24.
//

import SwiftUI
/*
// Fetching Events
@MainActor
private func getEventsFromAPI() async throws -> [Event] {
    let urlString = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=YDdWVD3tLoEwqXLhfVxU71agyjaUjkd7"
    
    guard let url = URL(string: urlString) else {
        throw HTTPError.invalidURL
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    do {
        let result = try JSONDecoder().decode(EventResponse.self, from: data)
        return result._embedded.events
    } catch {
        throw HTTPError.decodingError
    }
}
*/
// SwiftUI View
/*
struct Test: View {
    
    @State private var events: [Event] = []
    @State private var favoriteEvents: [Event] = []
 
    private func fetchEvents() {
        Task {
            do {
                events = try await getEventsFromAPI()
            } catch let error as HTTPError {
                print(error.message)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
  */
    
    /*
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(events, id: \.id) { event in
                            VStack(alignment: .leading) {
                                Text(event.name)
                                    .font(.headline)
                                Text("Date: \(event.dates.start.localDate)")
                                if let localTime = event.dates.start.localTime {
                                    Text("Time: \(localTime)")
                                }
                                Link("Details", destination: URL(string: event.url)!)
                                    .foregroundColor(.blue)
                                
                                Spacer()
                                
                                Button(action: {
                                    toggleFavorite(for: event)
                                }) {
                                    Image(systemName: isFavorite(event) ? "heart.fill" : "heart")
                                        .foregroundColor(isFavorite(event) ? .red : .gray)
                                }
                                .padding([.top], 8)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                            .frame(width: 250)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 200)
                
                Divider()
                
                List(favoriteEvents, id: \.id) { event in
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Events")
            .task {
                fetchEvents()
            }
        }
    }
    
    private func toggleFavorite(for event: Event) {
        if let index = favoriteEvents.firstIndex(where: { $0.id == event.id }) {
            favoriteEvents.remove(at: index)
        } else {
            favoriteEvents.append(event)
        }
    }
    
    private func isFavorite(_ event: Event) -> Bool {
        favoriteEvents.contains(where: { $0.id == event.id })
    }
}

#Preview {
    Test()
}
*/
