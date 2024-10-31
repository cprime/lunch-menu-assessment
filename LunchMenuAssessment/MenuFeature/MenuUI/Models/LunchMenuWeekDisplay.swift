//
//  LunchMenuWeekDisplay.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

extension LunchMenuWeek {
  static private let formatter = {
    var formatter = DateFormatter()
    formatter.dateFormat = "MMMM d"
    formatter.timeZone = TimeZone.gmt
    return formatter
  }()

  var title: String {
    return [startOfWeek, startOfWeek.addDays(6)]
      .compactMap({ $0 })
      .map({ LunchMenuWeek.formatter.string(from: $0) })
      .joined(separator: " - ")
      .uppercased()
  }
}
