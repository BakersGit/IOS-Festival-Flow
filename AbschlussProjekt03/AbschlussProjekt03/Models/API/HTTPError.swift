
import Foundation

enum HTTPError: Error {
    case invalidURL
    case decodingError
    
    var message: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .decodingError: return "Error decoding data"
        }
    }
}
