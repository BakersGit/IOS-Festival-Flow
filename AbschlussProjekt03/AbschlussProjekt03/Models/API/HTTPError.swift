
import Foundation

enum HTTPError: Error {
    case invalidURL
    case decodingError
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .decodingError:
            return """
            Error loading Data
            Please try to enter Valid Event Name/Data and try again.
            For example: Try searching for 'Rock', 'Electronic', 'Techno' and so on..
            """
        }
    }
}
