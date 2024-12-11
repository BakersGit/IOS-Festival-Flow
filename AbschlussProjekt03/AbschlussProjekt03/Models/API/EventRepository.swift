
import Foundation

class EventRepository {
    
    func getEventsFromAPI(keyword: String, countryCode: String = "DE") async throws -> [Event] {
        let urlString = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=YDdWVD3tLoEwqXLhfVxU71agyjaUjkd7&keyword=\(keyword)&size=50&page=0&countryCode=\(countryCode)"
        
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
}







 /*
     func getEventsFromAPI() async throws -> [Event] {
        let urlString = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=YDdWVD3tLoEwqXLhfVxU71agyjaUjkd7&keyword=Electronic&size=20&page=0&countryCode=DE"
        
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
}


*/

/* Key Trial
 https://app.ticketmaster.com/discovery/v2/events.json?apikey=YDdWVD3tLoEwqXLhfVxU71agyjaUjkd7
 */

