import Foundation

public protocol Network {
  func fetch<T: APIRequest>(api: URLGenerator, method: HTTPMethod, request: T) async throws -> T.ResponseDataType?
}

public extension Network {
  func fetch<T: APIRequest>(api: URLGenerator, method: HTTPMethod, request: T) async throws -> T.ResponseDataType? {
    try await fetch(api: api, method: method, request: request)
  }

}
