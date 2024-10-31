//
//  DateExtensions.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Foundation

extension Date {
  static func fromISO8601(_ value: String, timezone: TimeZone = .gmt) -> Date? {
    let formatter = ISO8601DateFormatter()
    formatter.timeZone = timezone
    return formatter.date(from: value)
  }

  func startOfDay(timezone: TimeZone = .gmt) -> Date? {
    var calendar = Calendar(identifier: .iso8601)
    calendar.timeZone = timezone
    var components = calendar.dateComponents([.year, .month, .day], from: self)
    components.timeZone = timezone
    return calendar.date(from: components)
  }

  func startOfWeek(timezone: TimeZone = .gmt) -> Date? {
    var calendar = Calendar(identifier: .iso8601)
    calendar.timeZone = timezone
    var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
    components.timeZone = timezone
    return calendar.date(from: components)
  }

  func addDays(_ days: Int, timezone: TimeZone = .gmt) -> Date? {
    var calendar = Calendar(identifier: .iso8601)
    calendar.timeZone = timezone
    return calendar.date(byAdding: .day, value: days, to: self)
  }

  func daysBetween(_ other: Date, timezone: TimeZone = .gmt) -> Int? {
    var calendar = Calendar(identifier: .iso8601)
    calendar.timeZone = timezone
    let components = calendar.dateComponents([.day], from: self, to: other)
    return components.day != nil ? abs(components.day!) : nil
  }
}
