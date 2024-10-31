//
//  MenuRestAPIService.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

struct HTTPError: Error {
  let message: String
}

class MenuRestAPIService: MenuAPIService {
  func fetchMenu() async throws -> Menu {
    let response: MenuResponse = try await execute(.getMenu)
    return Menu.Mapper.from(response: response)
  }
}

// Replace with an HTTPClient
func execute<T: Decodable>(_ request: HTTPRequest) async throws -> T {
  try await Task.sleep(for: .seconds(3))
  switch request {
  case .getMenu:
    return MenuResponse(
      referenceDate: Date.fromISO8601("2024-09-02T00:00:00Z")!,
      weeks: [
        ["Chicken and waffles", "Tacos", "Curry", "Pizza", "Sushi"],
        ["Breakfast for lunch", "Hamburgers", "Spaghetti", "Salmon", "Sandwiches"],
      ]
    ) as! T
  default:
    throw HTTPError(message: "UnsupportedRequest")
  }
}
