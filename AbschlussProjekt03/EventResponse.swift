/*
import Foundation

struct EventResponse: Codable {
    let _embedded: EmbeddedEvents
}

struct EmbeddedEvents: Codable {
    let events: [Event]
}


struct Event: Codable {
    let name: String
    let dates: EventDates
    let images: [EventImage]
    let url: String
    let _embedded: EventEmbedded?
}

struct EventDates: Codable {
    let start: EventStart
}

struct EventStart: Codable {
    let localDate: String
    let localTime: String?
}

struct EventImage: Codable {
    let url: String
}

struct EventEmbedded: Codable {
    let attractions: [Attraction]?
    let venues: [Venue]?
}

struct Attraction: Codable {
    let name: String
    let url: String?
}

struct Venue: Codable {
    let name: String
    let city: City
    let state: State
    let country: Country
    let address: Address
    let location: Location
}

struct City: Codable {
    let name: String
}

struct State: Codable {
    let name: String
    let stateCode: String
}

struct Country: Codable {
    let name: String
    let countryCode: String
}

struct Address: Codable {
    let line1: String
}

struct Location: Codable {
    let latitude: String
    let longitude: String
}
*/
