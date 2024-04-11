import Foundation

public enum NetworkError: Error {
  case httpError(statusCode: Int)
  case decodingError(Error)
}

// MARK: - NetworkManager Class
public class NetworkManager {
  private let session: URLSession

  init(configuration: URLSessionConfiguration = .default) {
    session = URLSession(configuration: configuration)
  }

  func performRequest<ResponseType: NetworkResponse>(_ request: NetworkRequest<ResponseType>) async throws -> ResponseType {
    // create the URL object
    var urlRequest = URLRequest(url: request.url)
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = request.headers
    urlRequest.httpBody = request.body

    // fetch the data from the server
    let (data, response) = try await session.data(for: urlRequest)

    // check to make sure the httpResponse code is not outside of the 200...299 range
    if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
      throw NetworkError.httpError(statusCode: httpResponse.statusCode)
    }

    // try to decode JSON response into ResponseType object
    do {
      let decodedResponse = try JSONDecoder().decode(ResponseType.self, from: data)
      return decodedResponse
    } catch {
      throw NetworkError.decodingError(error)
    }
  }
}
