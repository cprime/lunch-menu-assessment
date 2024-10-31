//
//  LunchMenuDayDisplay.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

extension LunchMenuDay {
  static private let dayOfWeekFormatter = {
    var formatter = DateFormatter()
    formatter.dateFormat = "EEE"
    formatter.timeZone = TimeZone.gmt
    return formatter
  }()

  static private let dayOfMonthFormatter = {
    var formatter = DateFormatter()
    formatter.dateFormat = "dd"
    formatter.timeZone = TimeZone.gmt
    return formatter
  }()

  var dayOfWeek: String {
    LunchMenuDay.dayOfWeekFormatter.string(from: date).uppercased()
  }

  var dayOfMonth: String {
    LunchMenuDay.dayOfMonthFormatter.string(from: date)
  }
}
