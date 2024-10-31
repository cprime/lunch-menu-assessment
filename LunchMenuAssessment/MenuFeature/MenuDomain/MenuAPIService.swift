//
//  MenuAPIService.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

protocol MenuAPIService {
  func fetchMenu() async throws -> Menu
}
