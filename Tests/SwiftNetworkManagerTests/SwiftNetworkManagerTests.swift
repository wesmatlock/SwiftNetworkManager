import XCTest
@testable import SwiftNetworkManager

final class SwiftNetworkManagerTests: XCTestCase {
  func testNetworkRequest() async throws {
    let networkManager = NetworkManager()
    let countryName = "Canada"
    let response = try? await networkManager.performRequest(.searchCountryByName(countryName))
    XCTAssertNotNil(response?.first?.name.common)
  }
}

struct Country: NetworkResponse {
  let name: CountryName

  struct CountryName: Codable {
    let common: String
    let official: String
  }
}

// Define how the NetworkRequest is created
extension NetworkRequest where ResponseType == [Country] {
  static func searchCountryByName(_ name: String) -> NetworkRequest<[Country]> {
    let urlString = "https://restcountries.com/v3.1/name/\(name)?fullText=true"
    guard let url = URL(string: urlString) else {
      fatalError("Invalid URL: \(urlString)")
    }

    return NetworkRequest<[Country]>(method: .get, url: url, headers: nil, body: nil)
  }
}
