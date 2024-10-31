//
//  MenuDataSource.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import XCTest

@testable import LunchMenuAssessment

private class MenuDataSourceTests: XCTestCase {
  var sut: DefaultMenuDataSource!
  var mockAPIService: MockMenuAPIService!

  override func setUp() {
    super.setUp()
    mockAPIService = MockMenuAPIService()
    sut = DefaultMenuDataSource(apiService: mockAPIService)
  }

  override func tearDown() {
    sut = nil
    mockAPIService = nil
    super.tearDown()
  }

  func testFetchMenu_WhenSuccessful_ReturnsMenu() async throws {
    let date = Date.fromISO8601("2024-10-28T00:00:00Z")!
    let weeks = [["A", "B"], ["C", "D"]]
    let expectedMenu = Menu(referenceDate: date, weeks: weeks)
    mockAPIService.mockMenu = expectedMenu

    let result = try await sut.fetchMenu()

    XCTAssertEqual(result, expectedMenu)
  }

  func testFetchMenu_WhenAPIFails_ThrowsError() async {
    let expectedError = NSError(domain: "TestError", code: -1)
    mockAPIService.mockError = expectedError

    do {
      _ = try await sut.fetchMenu()
      XCTFail("Expected function to throw error")
    } catch {
      XCTAssertEqual((error as NSError).domain, expectedError.domain)
      XCTAssertEqual((error as NSError).code, expectedError.code)
    }
  }
}

// MARK: - Mock Objects

private class MockMenuAPIService: MenuAPIService {
  var mockMenu: Menu?
  var mockError: Error?

  func fetchMenu() async throws -> Menu {
    if let error = mockError {
      throw error
    }

    guard let menu = mockMenu else {
      fatalError("Mock menu not set")
    }

    return menu
  }
}
