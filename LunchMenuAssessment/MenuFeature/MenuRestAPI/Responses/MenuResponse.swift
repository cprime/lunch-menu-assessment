//
//  MenuResponse.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

struct MenuResponse: Codable {
  let referenceDate: Date
  let weeks: [[String]]
}
