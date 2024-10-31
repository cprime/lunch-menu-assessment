//
//  MenuMapperTests.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import XCTest

@testable import LunchMenuAssessment

class MenuMapperTests: XCTestCase {
  func test() throws {
    let date = Date()
    let weeks = [["A", "B"], ["C", "D"]]
    let response = MenuResponse(referenceDate: date, weeks: weeks)

    XCTAssertEqual(
      Menu.Mapper.from(response: response),
      Menu(referenceDate: date, weeks: weeks)
    )
  }
}
