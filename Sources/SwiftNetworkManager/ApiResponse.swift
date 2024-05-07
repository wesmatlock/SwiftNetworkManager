import Foundation

public enum ApiResponse<T> {
  case success(T)
  case failure(APIError)

  public var result: Result<T?, APIError> {
    switch self {
    case .success(let value):
      return .success(value)
    case .failure(let aPIError):
      return .failure(aPIError)
    }
  }
}
