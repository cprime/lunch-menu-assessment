//
//  LunchMenuTests.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import XCTest

@testable import LunchMenuAssessment

class LunchMenuTests: XCTestCase {
  let menu = Menu(
    referenceDate: Date.fromISO8601("2024-09-02T00:00:00Z")!,
    weeks: [
      ["Chicken and waffles", "Tacos", "Curry", "Pizza", "Sushi"],
      ["Breakfast for lunch", "Hamburgers", "Spaghetti", "Salmon", "Sandwiches"],
    ]
  )

  func test_generate() {
    let lunchMenu = try? LunchMenu.generate(
      for: menu,
      startDate: Date.fromISO8601("2024-10-28T00:00:00Z")!,
      numberOfWeeks: 2
    )

    guard let lunchMenu = lunchMenu else {
      XCTFail()
      return
    }

    XCTAssertEqual(lunchMenu.template, menu)
    XCTAssertEqual(lunchMenu.startDate, Date.fromISO8601("2024-10-28T00:00:00Z"))
    XCTAssertEqual(lunchMenu.endDate, Date.fromISO8601("2024-11-11T00:00:00Z"))
    XCTAssertEqual(lunchMenu.weeks.count, 2)

    guard lunchMenu.weeks.count >= 1 else {
      XCTFail()
      return
    }

    XCTAssertEqual(lunchMenu.weeks[0].days.count, 5)
    XCTAssertEqual(lunchMenu.weeks[0].days[0], LunchMenuDay(date: Date.fromISO8601("2024-10-28T00:00:00Z")!, meal: "Chicken and waffles"))
    XCTAssertEqual(lunchMenu.weeks[0].days[1], LunchMenuDay(date: Date.fromISO8601("2024-10-29T00:00:00Z")!, meal: "Tacos"))
    XCTAssertEqual(lunchMenu.weeks[0].days[2], LunchMenuDay(date: Date.fromISO8601("2024-10-30T00:00:00Z")!, meal: "Curry"))
    XCTAssertEqual(lunchMenu.weeks[0].days[3], LunchMenuDay(date: Date.fromISO8601("2024-10-31T00:00:00Z")!, meal: "Pizza"))
    XCTAssertEqual(lunchMenu.weeks[0].days[4], LunchMenuDay(date: Date.fromISO8601("2024-11-01T00:00:00Z")!, meal: "Sushi"))

    guard lunchMenu.weeks.count >= 2 else {
      XCTFail()
      return
    }

    XCTAssertEqual(lunchMenu.weeks[1].days.count, 5)
    XCTAssertEqual(lunchMenu.weeks[1].days[0], LunchMenuDay(date: Date.fromISO8601("2024-11-04T00:00:00Z")!, meal: "Breakfast for lunch"))
    XCTAssertEqual(lunchMenu.weeks[1].days[1], LunchMenuDay(date: Date.fromISO8601("2024-11-05T00:00:00Z")!, meal: "Hamburgers"))
    XCTAssertEqual(lunchMenu.weeks[1].days[2], LunchMenuDay(date: Date.fromISO8601("2024-11-06T00:00:00Z")!, meal: "Spaghetti"))
    XCTAssertEqual(lunchMenu.weeks[1].days[3], LunchMenuDay(date: Date.fromISO8601("2024-11-07T00:00:00Z")!, meal: "Salmon"))
    XCTAssertEqual(lunchMenu.weeks[1].days[4], LunchMenuDay(date: Date.fromISO8601("2024-11-08T00:00:00Z")!, meal: "Sandwiches"))
  }

  func test_extended() {
    let lunchMenu = try? LunchMenu.generate(
      for: menu,
      startDate: Date.fromISO8601("2024-10-28T00:00:00Z")!,
      numberOfWeeks: 2
    )
    let extendedLunchMenu = try? lunchMenu?.extended(byNumberOfWeeks: 2)

    guard let extendedLunchMenu = extendedLunchMenu else {
      XCTFail()
      return
    }

    XCTAssertEqual(extendedLunchMenu.template, menu)
    XCTAssertEqual(extendedLunchMenu.startDate, Date.fromISO8601("2024-10-28T00:00:00Z"))
    XCTAssertEqual(extendedLunchMenu.endDate, Date.fromISO8601("2024-11-25T00:00:00Z"))
    XCTAssertEqual(extendedLunchMenu.weeks.count, 4)

    guard extendedLunchMenu.weeks.count >= 3 else {
      XCTFail()
      return
    }

    XCTAssertEqual(extendedLunchMenu.weeks[2].days.count, 5)
    XCTAssertEqual(extendedLunchMenu.weeks[2].days[0], LunchMenuDay(date: Date.fromISO8601("2024-11-11T00:00:00Z")!, meal: "Chicken and waffles"))
    XCTAssertEqual(extendedLunchMenu.weeks[2].days[1], LunchMenuDay(date: Date.fromISO8601("2024-11-12T00:00:00Z")!, meal: "Tacos"))
    XCTAssertEqual(extendedLunchMenu.weeks[2].days[2], LunchMenuDay(date: Date.fromISO8601("2024-11-13T00:00:00Z")!, meal: "Curry"))
    XCTAssertEqual(extendedLunchMenu.weeks[2].days[3], LunchMenuDay(date: Date.fromISO8601("2024-11-14T00:00:00Z")!, meal: "Pizza"))
    XCTAssertEqual(extendedLunchMenu.weeks[2].days[4], LunchMenuDay(date: Date.fromISO8601("2024-11-15T00:00:00Z")!, meal: "Sushi"))

    guard extendedLunchMenu.weeks.count >= 4 else {
      XCTFail()
      return
    }

    XCTAssertEqual(extendedLunchMenu.weeks[3].days.count, 5)
    XCTAssertEqual(extendedLunchMenu.weeks[3].days[0], LunchMenuDay(date: Date.fromISO8601("2024-11-18T00:00:00Z")!, meal: "Breakfast for lunch"))
    XCTAssertEqual(extendedLunchMenu.weeks[3].days[1], LunchMenuDay(date: Date.fromISO8601("2024-11-19T00:00:00Z")!, meal: "Hamburgers"))
    XCTAssertEqual(extendedLunchMenu.weeks[3].days[2], LunchMenuDay(date: Date.fromISO8601("2024-11-20T00:00:00Z")!, meal: "Spaghetti"))
    XCTAssertEqual(extendedLunchMenu.weeks[3].days[3], LunchMenuDay(date: Date.fromISO8601("2024-11-21T00:00:00Z")!, meal: "Salmon"))
    XCTAssertEqual(extendedLunchMenu.weeks[3].days[4], LunchMenuDay(date: Date.fromISO8601("2024-11-22T00:00:00Z")!, meal: "Sandwiches"))
  }
}
