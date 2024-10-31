//
//  LunchMenuDayDisplayTests.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import XCTest

@testable import LunchMenuAssessment

class LunchMenuDayDisplayTests: XCTestCase {
  func test_dayOfWeek() {
    let day = LunchMenuDay(date: Date.fromISO8601("2024-10-28T00:00:00Z")!, meal: "A")
    XCTAssertEqual(day.dayOfWeek, "MON")
  }

  func test_dayOfMonth() {
    let day = LunchMenuDay(date: Date.fromISO8601("2024-10-28T00:00:00Z")!, meal: "A")
    XCTAssertEqual(day.dayOfMonth, "28")
  }
}
