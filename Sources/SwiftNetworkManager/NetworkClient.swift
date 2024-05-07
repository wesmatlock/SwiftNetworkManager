import Foundation

public final class NetworkClient: Network {
  private let urlSession: URLSession

  public init(urlSession: URLSession = .shared) {
    self.urlSession = urlSession
  }

  public func fetch<T: APIRequest>(
    api: URLGenerator,
    method: HTTPMethod,
    request: T
  ) async throws -> T.ResponseDataType? {
    let urlRequest = try createURLRequest(api: api, method: method, request: request)
    let (data, response) = try await urlSession.data(for: urlRequest)
    return try parseData(data, for: request)
  }

  private func createURLRequest<T: APIRequest>(api: URLGenerator, method: HTTPMethod, request: T) throws -> URLRequest {
    let urlRequest = try request.make(api: api, method: method)
    return urlRequest
  }

  private func parseData<T: APIRequest>(_ data: Data, for request: T) throws -> T.ResponseDataType {
    try request.parseResponse(data: data)
  }
}
