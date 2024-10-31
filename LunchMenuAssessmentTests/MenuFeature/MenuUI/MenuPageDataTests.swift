//
//  MenuPageDataTests.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import XCTest

@testable import LunchMenuAssessment

class MenuPageDataTests: XCTestCase {
  func test_highlightWeek() {
    let monday = Date.fromISO8601("2024-10-28T00:00:00Z")!
    let weeks = [["A"], ["B"]]
    let menu = Menu(referenceDate: monday, weeks: weeks)
    let week1 = LunchMenuWeek(
      startOfWeek: Date.fromISO8601("2024-10-28T00:00:00Z")!,
      days: [
        LunchMenuDay(date: Date.fromISO8601("2024-10-28T00:00:00Z")!, meal: "A"),
      ]
    )
    let week2 = LunchMenuWeek(
      startOfWeek: Date.fromISO8601("2024-11-04T00:00:00Z")!,
      days: [
        LunchMenuDay(date: Date.fromISO8601("2024-10-28T00:00:00Z")!, meal: "A"),
      ]
    )
    let lunchMenu = LunchMenu(
      template: menu,
      startDate: monday,
      endDate: Date.fromISO8601("2024-11-04T00:00:00Z")!,
      weeks: [week1, week2]
    )
    let menuPageData = MenuPageData(menu: lunchMenu, today: Date.fromISO8601("2024-10-30T00:00:00Z")!)

    XCTAssertTrue(menuPageData.highlightWeek(week1))
    XCTAssertFalse(menuPageData.highlightWeek(week2))
  }

  func test_highlightDay() {
    let monday = Date.fromISO8601("2024-10-28T00:00:00Z")!
    let weeks = [["A", "B", "C", "D", "E"]]
    let menu = Menu(referenceDate: monday, weeks: weeks)
    let week = LunchMenuWeek(
      startOfWeek: Date.fromISO8601("2024-10-28T00:00:00Z")!,
      days: [
        LunchMenuDay(date: Date.fromISO8601("2024-10-28T00:00:00Z")!, meal: "A"),
        LunchMenuDay(date: Date.fromISO8601("2024-10-29T00:00:00Z")!, meal: "B"),
        LunchMenuDay(date: Date.fromISO8601("2024-10-30T00:00:00Z")!, meal: "C"),
        LunchMenuDay(date: Date.fromISO8601("2024-10-31T00:00:00Z")!, meal: "D"),
        LunchMenuDay(date: Date.fromISO8601("2024-11-01T00:00:00Z")!, meal: "E"),
      ]
    )
    let lunchMenu = LunchMenu(
      template: menu,
      startDate: monday,
      endDate: Date.fromISO8601("2024-11-04T00:00:00Z")!,
      weeks: [
        week
      ]
    )
    let menuPageData = MenuPageData(menu: lunchMenu, today: Date.fromISO8601("2024-10-30T00:00:00Z")!)

    XCTAssertFalse(menuPageData.highlightDay(lunchMenu.weeks[0].days[0]))
    XCTAssertFalse(menuPageData.highlightDay(lunchMenu.weeks[0].days[1]))
    XCTAssertTrue(menuPageData.highlightDay(lunchMenu.weeks[0].days[2]))
    XCTAssertFalse(menuPageData.highlightDay(lunchMenu.weeks[0].days[3]))
    XCTAssertFalse(menuPageData.highlightDay(lunchMenu.weeks[0].days[4]))
  }
}
