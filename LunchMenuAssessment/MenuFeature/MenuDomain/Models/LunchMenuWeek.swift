//
//  LunchMenuWeek.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

struct LunchMenuWeek: Equatable, Hashable {
  let startOfWeek: Date
  let days: [LunchMenuDay]
}
