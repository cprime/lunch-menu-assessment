//
//  DateExtensionTests.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import XCTest

@testable import LunchMenuAssessment

class DateExtensionTests: XCTestCase {
  func test_fromISO8601() throws {
    XCTAssertEqual(
      Date.fromISO8601("2024-10-28T00:00:00Z"),
      Calendar(identifier: .iso8601).date(from: DateComponents(timeZone: .gmt, year: 2024, month: 10, day: 28))
    )
    XCTAssertEqual(
      Date.fromISO8601("2024-10-28T12:00:00Z"),
      Calendar(identifier: .iso8601).date(
        from: DateComponents(timeZone: .gmt, year: 2024, month: 10, day: 28, hour: 12))
    )
  }

  func test_startOfDay() throws {
    XCTAssertEqual(
      Date.fromISO8601("2024-10-28T00:00:00Z")?.startOfDay(),
      Date.fromISO8601("2024-10-28T00:00:00Z")
    )
    XCTAssertEqual(
      Date.fromISO8601("2024-10-29T12:00:00Z")?.startOfDay(),
      Date.fromISO8601("2024-10-29T00:00:00Z")
    )
    XCTAssertEqual(
      Date.fromISO8601("2024-10-27T23:59:59Z")?.startOfDay(),
      Date.fromISO8601("2024-10-27T00:00:00Z")
    )
  }

  func test_startOfWeek() throws {
    XCTAssertEqual(
      Date.fromISO8601("2024-10-28T00:00:00Z")?.startOfWeek(),
      Date.fromISO8601("2024-10-28T00:00:00Z")
    )
    XCTAssertEqual(
      Date.fromISO8601("2024-10-29T00:00:00Z")?.startOfWeek(),
      Date.fromISO8601("2024-10-28T00:00:00Z")
    )
    XCTAssertEqual(
      Date.fromISO8601("2024-10-27T23:59:59Z")?.startOfWeek(),
      Date.fromISO8601("2024-10-21T00:00:00Z")
    )
  }

  func test_addDays() {
    XCTAssertEqual(
      Date.fromISO8601("2024-10-28T00:00:00Z")?.addDays(7),
      Date.fromISO8601("2024-11-04T00:00:00Z")
    )
    XCTAssertEqual(
      Date.fromISO8601("2024-10-29T00:00:00Z")?.addDays(7),
      Date.fromISO8601("2024-11-05T00:00:00Z")
    )
    XCTAssertEqual(
      Date.fromISO8601("2024-10-27T23:59:59Z")?.addDays(7),
      Date.fromISO8601("2024-11-03T23:59:59Z")
    )
  }

  func test_weeksBetween() {
    XCTAssertEqual(
      Date.fromISO8601("2024-10-28T00:00:00Z")?.daysBetween(Date.fromISO8601("2024-10-28T00:00:00Z")!),
      0
    )
    XCTAssertEqual(
      Date.fromISO8601("2024-09-02T00:00:00Z")?.daysBetween(Date.fromISO8601("2024-10-28T00:00:00Z")!),
      56
    )
  }
}
