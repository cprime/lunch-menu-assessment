//
//  MenuDataSource.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

protocol MenuDataSource {
  func fetchMenu() async throws -> Menu
}

// TODO: Add support for caching
class DefaultMenuDataSource: MenuDataSource {
  let apiService: MenuAPIService
//   let dataStore: MenuStorageService

  init(apiService: MenuAPIService/*, dataStore: MenuStorageService*/) {
    self.apiService = apiService
//    self.dataStore = dataStore
  }

  func fetchMenu() async throws -> Menu {
    let menu = try await apiService.fetchMenu()
//    try? await dataStore.save(menu)
    return menu
  }
}

//protocol MenuStorageService {
//  func save(_ menu: Menu) async throws
//}
