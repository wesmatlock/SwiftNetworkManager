import Foundation

public enum HTTPError: Error {
  // 400
  case badRequest
  // 401
  case unauthorized
  // 403
  case forbidden
  // 404
  case notFound
  // 500
  case serverError
  // ??
  case unknown

  var localizedDescription: String {
    switch self {
    case .badRequest:
      return "Bad Request"
    case .unauthorized:
      return "Unauthorized"
    case .forbidden:
      return "Forbidden"
    case .notFound:
      return "Not Found"
    case .serverError:
      return "Server Error"
    case .unknown:
      return "Unknown HTTP Error"
    }
  }
}
