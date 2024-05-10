//
//  File.swift
//  
//
//  Created by Wesley Matlock on 5/7/24.
//

import Foundation
@testable import SwiftNetworkManager

enum Api: URLGenerator {
  case list
  case images(breed: Breed)
  var url: URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "dog.ceo"
    components.path = path
    return components.url
  }
}

extension Api {
  fileprivate var path: String {
    switch self {
    case .list:
      return "/api/breeds/list/all"
    case .images(let breed):
      if let subBreed = breed.sub {
        return "/api/breed/\(breed.master)/\(subBreed)/images/random/10"
      }
      return "/api/breed/\(breed.master)/images/random/10"
    }
  }
}

struct Breed: Decodable {
  let sub: Sub?
  let master: String

  struct Sub: Decodable {
    let name: String
  }
}

struct DogRequest: APIRequest {
  func parseResponse(data: Data) throws -> Breed {
    let decoder = JSONDecoder()
    return try decoder.decode(Breed.self, from: data)
  }
}
