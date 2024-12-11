
/*
 import Foundation

struct DanceEvent: Codable {
    let context: String
    let type: String
    let id: String
    let name: String
    let startDate: String
    let endDate: String
    let eventAttendanceMode: String
    let eventStatus: String
    let description: String
    let performers: String
    let url: String
    let sameAs: [String]
    let image: EventImage
    let offers: Offer
    let location: EventLocation
    let organizer: Organizer

    enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type = "@type"
        case id = "@id"
        case name
        case startDate
        case endDate
        case eventAttendanceMode
        case eventStatus
        case description
        case performers
        case url
        case sameAs
        case image
        case offers
        case location
        case organizer
    }
}

struct EventImage: Codable {
    let type: String
    let thumbnailUrl: String
    let url: String
    let width: Int
    let height: Int

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case thumbnailUrl
        case url
        case width
        case height
    }
}

struct Offer: Codable {
    let type: String
    let url: String
    let price: Double
    let priceCurrency: String
    let availability: String
    let validFrom: String

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case url
        case price
        case priceCurrency
        case availability
        case validFrom
    }
}

struct EventLocation: Codable {
    let type: String
    let name: String
    let address: PostalAddress
    let geo: GeoCoordinates
    let hasMap: MapLink

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case name
        case address
        case geo
        case hasMap
    }
}

struct PostalAddress: Codable {
    let type: String
    let addressCountry: String
    let streetAddress: String
    let addressLocality: String
    let postalCode: String

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case addressCountry
        case streetAddress
        case addressLocality
        case postalCode
    }
}

struct GeoCoordinates: Codable {
    let type: String
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case latitude
        case longitude
    }
}

struct MapLink: Codable {
    let type: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case url
    }
}

struct Organizer: Codable {
    let type: String
    let email: String
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case email
        case name
        case url
    }
}
*/
