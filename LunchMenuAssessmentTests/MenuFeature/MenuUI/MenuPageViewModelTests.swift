//
//  MenuPageViewModelTests.swift
//  LunchMenuAssessment
//
//  Created by colden.prime on 10/30/24.
//

import Combine
import XCTest

@testable import LunchMenuAssessment

private let menu = Menu(
  referenceDate: Date.fromISO8601("2024-09-02T00:00:00Z")!,
  weeks: [
    ["Chicken and waffles", "Tacos", "Curry", "Pizza", "Sushi"],
    ["Breakfast for lunch", "Hamburgers", "Spaghetti", "Salmon", "Sandwiches"],
  ]
)

private class MenuPageViewModelTests: XCTestCase {
  var sut: MenuPageViewModel!
  var mockDataSource: MockMenuDataSource!
  var mockNowProvider: MockNowProvider!
  var cancellables: Set<AnyCancellable>!

  override func setUp() {
    super.setUp()
    mockDataSource = MockMenuDataSource()
    mockNowProvider = MockNowProvider()
    sut = MenuPageViewModel(
      dataSource: mockDataSource,
      nowProvider: mockNowProvider
    )
    cancellables = Set()
  }

  override func tearDown() {
    sut = nil
    mockDataSource = nil
    mockNowProvider = nil
    cancellables = nil
    super.tearDown()
  }

  func test_fetchMenu_Failure() async {
    var states: [ViewModelState<MenuPageData>] = []
    sut.$state.sink(receiveValue: { states.append($0) }).store(in: &cancellables)

    await sut.fetchMenu()

    // Assert loading state
    XCTAssertEqual(states.count, 3)
    guard states.count == 3 else {
      XCTFail()
      return
    }

    XCTAssertEqual(states[0], .idle)
    XCTAssertEqual(states[1], .loading)

    if case .error(let error) = states[2] {
      XCTAssertEqual(error as NSError, NSError(domain: "MockError", code: -1))
    } else {
      XCTFail()
    }
  }

  func test_fetchMenu_Success() async {
    mockNowProvider.mockNow = Date.fromISO8601("2024-10-30T12:00:00Z")!
    mockDataSource.mockFetchMenuResult = .success(menu)

    var states: [ViewModelState<MenuPageData>] = []
    sut.$state.sink(receiveValue: { states.append($0) }).store(in: &cancellables)

    await sut.fetchMenu()

    // Assert loading state
    XCTAssertEqual(states.count, 3)
    guard states.count == 3 else {
      XCTFail()
      return
    }

    XCTAssertEqual(states[0], .idle)
    XCTAssertEqual(states[1], .loading)

    if case .loaded(let actualLunchMenu) = states[2] {
      XCTAssertEqual(actualLunchMenu.today, Date.fromISO8601("2024-10-30T00:00:00Z")!)
      XCTAssertEqual(actualLunchMenu.menu.template, menu)
      XCTAssertEqual(actualLunchMenu.menu.startDate, Date.fromISO8601("2024-10-28T00:00:00Z")!)
      XCTAssertEqual(actualLunchMenu.menu.endDate, Date.fromISO8601("2024-12-23T00:00:00Z")!)
      XCTAssertEqual(actualLunchMenu.menu.weeks.count, 8)
    } else {
      XCTFail()
    }
  }

  func test_extend() async {
    mockNowProvider.mockNow = Date.fromISO8601("2024-10-30T12:00:00Z")!
    mockDataSource.mockFetchMenuResult = .success(menu)
    await sut.fetchMenu()
    await sut.extendMenu()

    if case .loaded(let actualLunchMenu) = sut.state {
      XCTAssertEqual(actualLunchMenu.today, Date.fromISO8601("2024-10-30T00:00:00Z")!)
      XCTAssertEqual(actualLunchMenu.menu.template, menu)
      XCTAssertEqual(actualLunchMenu.menu.startDate, Date.fromISO8601("2024-10-28T00:00:00Z")!)
      XCTAssertEqual(actualLunchMenu.menu.endDate, Date.fromISO8601("2025-02-17T00:00:00Z")!)
      XCTAssertEqual(actualLunchMenu.menu.weeks.count, 16)
    } else {
      XCTFail()
    }
  }
}

// MARK: - Mock Objects

private class MockMenuDataSource: MenuDataSource {
  var mockFetchMenuResult: Result<Menu, Error>?

  func fetchMenu() async throws -> Menu {
    guard let result = mockFetchMenuResult else {
      throw NSError(domain: "MockError", code: -1)
    }
    return try result.get()
  }
}

private class MockNowProvider: NowProvider {
  var mockNow: Date?

  var now: Date {
    return mockNow ?? Date()
  }
}

extension ViewModelState: @retroactive Equatable {
  public static func == (lhs: ViewModelState<T>, rhs: ViewModelState<T>) -> Bool {
    switch (lhs, rhs) {
    case (.idle, .idle):
      return true
    case (.loading, .loading):
      return true
    case (.loaded(let lhsData), .loaded(let rhsData)):
      return lhsData == rhsData
    case (.error(let lhsError as NSError), .error(let rhsError as NSError)):
      return lhsError.domain == rhsError.domain && lhsError.code == rhsError.code
    default:
      return false
    }
  }
}
