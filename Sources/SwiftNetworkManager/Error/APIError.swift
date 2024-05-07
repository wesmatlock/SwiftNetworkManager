import Foundation

public enum APIError: Equatable, Error {
  case network(errorMessage: String)
  case noData
  case parseResponse(errorMessage: String)
  case request
  case httpError(HTTPError)
  case invalidResponse(Data?, URLResponse?)
  case unknown

  var localizedDescription: String {
    switch self {
    case .network(let errorMessage):
      return errorMessage
    case .noData:
      return "No Data"
    case .parseResponse(let errorMessage):
      return errorMessage
    case .request:
      return "Unable to process request"
    case .httpError(let hTTPError):
      return hTTPError.localizedDescription
    case .invalidResponse:
      return "Invalid Response"
    case .unknown:
      return "Unknown API Error"
    }
  }
}
