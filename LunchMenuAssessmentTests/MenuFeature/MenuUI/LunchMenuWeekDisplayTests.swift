//
//  LunchMenuWeekDisplayTests.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import XCTest

@testable import LunchMenuAssessment

class LunchMenuWeekDisplayTests: XCTestCase {
  func test_title() {
    let week = LunchMenuWeek(
      startOfWeek: Date.fromISO8601("2024-10-28T00:00:00Z")!,
      days: [
        LunchMenuDay(date: Date.fromISO8601("2024-10-28T00:00:00Z")!, meal: "A"),
        LunchMenuDay(date: Date.fromISO8601("2024-10-29T00:00:00Z")!, meal: "B"),
        LunchMenuDay(date: Date.fromISO8601("2024-10-30T00:00:00Z")!, meal: "C"),
        LunchMenuDay(date: Date.fromISO8601("2024-10-31T00:00:00Z")!, meal: "D"),
        LunchMenuDay(date: Date.fromISO8601("2024-11-01T00:00:00Z")!, meal: "E")
      ]
    )
    XCTAssertEqual(week.title, "OCTOBER 28 - NOVEMBER 3")
  }
}
