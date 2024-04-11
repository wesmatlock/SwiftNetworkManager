import Foundation
/// See Tests on usage
public protocol NetworkResponse: Codable, Encodable { }

public struct NetworkRequest<ResponseType: NetworkResponse> {
  let method: HTTPMethod
  let url: URL
  let headers: [String: String]?
  let body: Data?
}

public extension NetworkRequest {
  enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
  }
}

extension Array: NetworkResponse where Element : NetworkResponse { }
