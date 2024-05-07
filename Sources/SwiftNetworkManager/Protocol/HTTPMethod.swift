import Foundation

public enum HTTPMethod {
  case get(headers: [String: String] = [:], token: String? = nil)
  case post(headers: [String: String] = [:], token: String? = nil, body: [String: Any])
  case put(headers: [String: String] = [:], token: String? = nil)
  case delete(headers: [String: String] = [:], token: String? = nil)
  case patch(headers: [String: String] = [:], token: String? = nil)
}

extension HTTPMethod: CustomStringConvertible {
  public var description: String {
    switch self {
    case .get:
      return "GET"
    case .post:
      return "POST"
    case .put:
      return "PUT"
    case .delete:
      return "DELETE"
    case .patch:
      return "PATCH"
    }
  }

  public var operation: String {
    return self.description
  }

  func getHeaders() -> [String: String]? {
    switch self {
    case .get(let headers, _):
      return headers
    case .post(let headers, _, _):
      return headers
    case .put(let headers, _):
      return headers
    case .delete(let headers, _):
      return headers
    case .patch(let headers, _):
      return headers
    }
  }

  func getToken() -> String? {
    switch self {
    case .get(_, token: let token):
      return token
    case .post(_, token: let token, body: _):
      return token
    case .put(_, token: let token):
      return token
    case .delete(_, token: let token):
      return token
    case .patch(_, token: let token):
      return token
    }
  }

  func getData() -> [String: Any]? {
    switch self {
    case .get:
      return nil
    case .post( _, _, body: let body):
      return body
    case .put:
      return nil
    case .delete:
      return nil
    case .patch:
      return nil
    }
  }
}
