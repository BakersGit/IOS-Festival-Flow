
import Foundation

struct EventResponse: Codable {
    let _embedded: EmbeddedEvents
}

struct EmbeddedEvents: Codable {
    let events: [Event]
}

struct Event: Codable, Identifiable {
    let id: String
    let name: String
    let dates: EventDates
    let url: String
    let images: [EventImage]

}
struct EventImage: Codable {
    let url: String
}

struct EventDates: Codable {
    let start: EventStart
}

struct EventStart: Codable {
    let localDate: String
    let localTime: String?
}
struct Location: Codable {
    let latitude: String
    let longitude: String
}
