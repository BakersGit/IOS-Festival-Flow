import Foundation

class GoaBaseEventRepository {
    func getEventsFromAPI() async throws -> [Festival] {
        let urlString = "https://www.goabase.net/api/party/jsonld/?country=de"
        guard let url = URL(string: urlString) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let eventList = try JSONDecoder().decode(GoabaseEventList.self, from: data)
            print("Total events in response: \(eventList.itemListElement.count)") 
            
            return try await withThrowingTaskGroup(of: Festival?.self) { group in
                for item in eventList.itemListElement {
                    group.addTask {
                        do {
                            let festival = try await self.fetchFestivalDetails(from: item.url)
                            print("Loaded event: \(festival.name)")
                            return festival
                        } catch {
                            print("Failed to load event from URL: \(item.url), error: \(error)")
                            return nil
                        }
                    }
                }
                
                var festivals: [Festival] = []
                for try await festival in group {
                    if let festival = festival {
                        festivals.append(festival)
                    }
                }
                print("Total successfully loaded festivals: \(festivals.count)")
                return festivals
            }
        } catch {
            print("Failed to decode GoabaseEventList: \(error)")
            throw HTTPError.decodingError
        }
    }
    
    private func fetchFestivalDetails(from url: String) async throws -> Festival {
        guard let detailURL = URL(string: url) else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: detailURL)
        
        do {
            let festival = try JSONDecoder().decode(Festival.self, from: data)
            return festival
        } catch {
            print("Failed to decode Festival details from URL: \(url), error: \(error)")
            throw HTTPError.decodingError
        }
    }
}
